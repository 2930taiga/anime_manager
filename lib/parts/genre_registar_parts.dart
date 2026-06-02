import 'package:anime_administration/models/genre.dart';
import 'package:flutter/material.dart';
//providerに関するものをインポート
import 'package:flutter_riverpod/flutter_riverpod.dart';
//providerの定義に関するスクリプトをインポート
import 'package:anime_administration/pages/main_navigation_pages/setting/genre/genre_registar.dart';

//コントローラをどうするかのprovider
final onEditiongFlagProvider = StateProvider<bool>((ref){
  return false;
});

//タイトル入力欄---------------------------------------------------------------------------------------
class TitleIputField extends ConsumerStatefulWidget {
  const TitleIputField({super.key});

  @override
  ConsumerState<TitleIputField> createState() => _TitleIputFieldState();
}

class _TitleIputFieldState extends ConsumerState<TitleIputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox( 
      width: MediaQuery.of(context).size.width*0.9,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (text){
          if(text==null || text ==""){
            return "ジャンル名を入力してください";
          }
          else{return null;}
        },
        onChanged: (text){
          if(text!=""){ //入力が正常
            //providerの値を更新
            ref.read(genreInputProvider.notifier).state=ref.read(genreInputProvider).copyWith(title: text);
            ref.read(genreCorrectInputProvider.notifier).state=ref.read(genreCorrectInputProvider).copyWith(title: true);
            return;
          }
          //入力値が異常
          ref.read(genreCorrectInputProvider.notifier).state=ref.read(genreCorrectInputProvider).copyWith(title: false);
          return;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "ジャンル名",
        ),
      ),
    );
  }
}

//題目---------------------------------------------------------------------------------------
class TitleText extends StatelessWidget {
  //タイトル
  final String titleText;
  //context

  const TitleText({super.key, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
      child: Row(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width*0.02,),

          Text(
            titleText,
            style: TextStyle(
              fontSize: 20
            ),
          )
        ],
      ),
    );
    
  }
}

//プレビュー欄---------------------------------------------------------------------------------------
class PreviewColor extends ConsumerStatefulWidget {
  const PreviewColor({super.key});

  @override
  ConsumerState<PreviewColor> createState() => _PreviewColorState();
}

class _PreviewColorState extends ConsumerState<PreviewColor> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
      child: Column(
        children: [
          // //プレビューテキスト
          Row(
            children: [
              Icon(
                ref.read(genreInputProvider.notifier).state.iconData,
                color: Color.fromARGB(255, ref.read(genreInputProvider.notifier).state.redValue, ref.read(genreInputProvider.notifier).state.greenValue, ref.read(genreInputProvider.notifier).state.blueValue),
                size: 30,
              ),
              SizedBox(width: MediaQuery.of(context).size.width*0.02,),
              Expanded(
                child: Text(
                  ref.read(genreInputProvider.notifier).state.title,
                  style: TextStyle(
                    fontSize: 19
                  ),
                )
              )
            ],
          )
        ],
      ),
    );
  }
}

//色入力欄---------------------------------------------------------------------------------------
//赤---------------------------------------------------------------------------------------
class RedInputField extends ConsumerStatefulWidget {
  const RedInputField({super.key});

  @override
  ConsumerState<RedInputField> createState() => _RedInputFieldState();
}

class _RedInputFieldState extends ConsumerState<RedInputField> {

  @override
  Widget build(BuildContext context) {
    return Row( //-------Red
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.73,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                  SizedBox(
                    child: Text(
                      "Red",
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox()
                  )
                ],
              ),
              SizedBox(
                child: Stack(
                  alignment: AlignmentGeometry.center,
                  children: [
                    Container(
                      height: 6,
                      width: MediaQuery.of(context).size.width*0.65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Color.fromARGB(255, 255, 0, 0)
                          ]
                        )
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbColor: Colors.white,
                        trackHeight: 0,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 12
                        )
                      ),
                      child: Slider(
                        min: 0,
                        max: 255,
                        value: ref.read(genreInputProvider.notifier).state.redValue.toDouble(),
                        onChanged: (index){
                          //スライダーが触られたらフォーカスを外す
                          FocusManager.instance.primaryFocus?.unfocus();
                          //編集中を解除
                          ref.read(onEditiongFlagProvider.notifier).state=false;
                          //providerの値を更新
                          ref.read(genreInputProvider.notifier).state=ref.read(genreInputProvider).copyWith(redValue: index.toInt());
                          ref.read(genreCorrectInputProvider.notifier).state=ref.read(genreCorrectInputProvider).copyWith(redValue: true);
                        }
                      )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text){
              //何かが入力されているかを判定
              if(text!=null){
                //入力が数字かを判定
                int? inpuNum = int.tryParse(text);
                if(inpuNum!=null){
                  //数値が0~255に収まっているかを確認
                  if(inpuNum>=0 && inpuNum <=255){
                    return null;
                  }
                }
              }
              //入力が異常
              return "異常値";
            },
            controller: ref.read(onEditiongFlagProvider.notifier).state
            ? null
            : TextEditingController(text: ref.watch(genreInputProvider.notifier).state.redValue.toString()),
            onChanged: (text){
              //入力が始まったら，コントローラを無効化
              ref.read(onEditiongFlagProvider.notifier).state=true;

              //入力を確認
              if(int.tryParse(text)!=null){
                int inputNum = int.tryParse(text) ?? -1;
                if(inputNum>=0 && inputNum <=255){ //入力が正常
                  //providerの値を更新
                  ref.read(genreInputProvider.notifier).state=ref.read(genreInputProvider).copyWith(redValue: inputNum);
                  ref.read(genreCorrectInputProvider.notifier).state=ref.read(genreCorrectInputProvider).copyWith(redValue: true);
                  return;
                }
              }
              //入力が異常
              //providerの値を更新
              ref.read(genreCorrectInputProvider.notifier).state=ref.read(genreCorrectInputProvider).copyWith(redValue: false);
            },
            textAlign: TextAlign.center, // 横方向の中央揃え
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
            ),
          )
        )
      ],
    );
  }
}

//緑---------------------------------------------------------------------------------------
class GreenInputField extends ConsumerStatefulWidget {
  const GreenInputField({super.key});

  @override
  ConsumerState<GreenInputField> createState() => _GreenInputFieldState();
}

class _GreenInputFieldState extends ConsumerState<GreenInputField> {

  @override
  Widget build(BuildContext context) {
    return Row( //-------Green
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.73,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                  SizedBox(
                    child: Text(
                      "Green",
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox()
                  )
                ],
              ),
              SizedBox(
                child: Stack(
                  alignment: AlignmentGeometry.center,
                  children: [
                    Container(
                      height: 6,
                      width: MediaQuery.of(context).size.width*0.65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Color.fromARGB(255, 0, 255, 0)
                          ]
                        )
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbColor: Colors.white,
                        trackHeight: 0,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 12
                        )
                      ),
                      child: Slider(
                        min: 0,
                        max: 255,
                        value: ref.read(genreInputProvider.notifier).state.greenValue.toDouble(),
                        onChanged: (index){
                          //スライダーが触られたらフォーカスを外す
                          FocusManager.instance.primaryFocus?.unfocus();
                          //編集中を解除
                          ref.read(onEditiongFlagProvider.notifier).state=false;
                          //providerの値を更新
                          ref.read(genreInputProvider.notifier).state=ref.read(genreInputProvider).copyWith(greenValue: index.toInt());
                          ref.read(genreCorrectInputProvider.notifier).state=ref.read(genreCorrectInputProvider).copyWith(greenValue: true);
                        }
                      )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text){
              //何かが入力されているかを判定
              if(text!=null){
                //入力が数字かを判定
                int? inpuNum = int.tryParse(text);
                if(inpuNum!=null){
                  //数値が0~255に収まっているかを確認
                  if(inpuNum>=0 && inpuNum <=255){
                    return null;
                  }
                }
              }
              //入力が異常
              return "異常値";
            },
            controller: ref.read(onEditiongFlagProvider.notifier).state
            ? null
            : TextEditingController(text: ref.watch(genreInputProvider.notifier).state.greenValue.toString()),
            onChanged: (text){
              //入力が始まったら，コントローラを無効化
              ref.read(onEditiongFlagProvider.notifier).state=true;

              //入力を確認
              if(int.tryParse(text)!=null){
                int inputNum = int.tryParse(text) ?? -1;
                if(inputNum>=0 && inputNum <=255){ //入力が正常
                  //providerの値を更新
                  ref.read(genreInputProvider.notifier).state=ref.read(genreInputProvider).copyWith(greenValue: inputNum);
                  ref.read(genreCorrectInputProvider.notifier).state=ref.read(genreCorrectInputProvider).copyWith(greenValue: true);
                  return;
                }
              }
              //入力が異常
              //providerの値を更新
              ref.read(genreCorrectInputProvider.notifier).state=ref.read(genreCorrectInputProvider).copyWith(greenValue: false);
            },
            textAlign: TextAlign.center, // 横方向の中央揃え
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
            ),
          )
        )
      ],
    );
  }
}

//青---------------------------------------------------------------------------------------
class BlueInputField extends ConsumerStatefulWidget {
  const BlueInputField({super.key});

  @override
  ConsumerState<BlueInputField> createState() => _BlueInputFieldState();
}

class _BlueInputFieldState extends ConsumerState<BlueInputField> {

  @override
  Widget build(BuildContext context) {
    return Row( //-------Blue
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.73,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                  SizedBox(
                    child: Text(
                      "Blue",
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox()
                  )
                ],
              ),
              SizedBox(
                child: Stack(
                  alignment: AlignmentGeometry.center,
                  children: [
                    Container(
                      height: 6,
                      width: MediaQuery.of(context).size.width*0.65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Color.fromARGB(255, 0, 0, 255)
                          ]
                        )
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbColor: Colors.white,
                        trackHeight: 0,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 12
                        )
                      ),
                      child: Slider(
                        min: 0,
                        max: 255,
                        value: ref.read(genreInputProvider.notifier).state.blueValue.toDouble(),
                        onChanged: (index){
                          //スライダーが触られたらフォーカスを外す
                          FocusManager.instance.primaryFocus?.unfocus();
                          //編集中を解除
                          ref.read(onEditiongFlagProvider.notifier).state=false;
                          //providerの値を更新
                          ref.read(genreInputProvider.notifier).state=ref.read(genreInputProvider).copyWith(blueValue: index.toInt());
                          ref.read(genreCorrectInputProvider.notifier).state=ref.read(genreCorrectInputProvider).copyWith(blueValue: true);
                        }
                      )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text){
              //何かが入力されているかを判定
              if(text!=null){
                //入力が数字かを判定
                int? inpuNum = int.tryParse(text);
                if(inpuNum!=null){
                  //数値が0~255に収まっているかを確認
                  if(inpuNum>=0 && inpuNum <=255){
                    return null;
                  }
                }
              }
              //入力が異常
              return "異常値";
            },
            controller: ref.read(onEditiongFlagProvider.notifier).state
            ? null
            : TextEditingController(text: ref.watch(genreInputProvider.notifier).state.blueValue.toString()),
            onChanged: (text){
              //入力が始まったら，コントローラを無効化
              ref.read(onEditiongFlagProvider.notifier).state=true;

              //入力を確認
              if(int.tryParse(text)!=null){
                int inputNum = int.tryParse(text) ?? -1;
                if(inputNum>=0 && inputNum <=255){ //入力が正常
                  //providerの値を更新
                  ref.read(genreInputProvider.notifier).state=ref.read(genreInputProvider).copyWith(blueValue: inputNum);
                  ref.read(genreCorrectInputProvider.notifier).state=ref.read(genreCorrectInputProvider).copyWith(blueValue: true);
                  return;
                }
              }
              //入力が異常
              //providerの値を更新
              ref.read(genreCorrectInputProvider.notifier).state=ref.read(genreCorrectInputProvider).copyWith(blueValue: false);
            },
            textAlign: TextAlign.center, // 横方向の中央揃え
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
            ),
          )
        )
      ],
    );
  }
}

//色入力アイコン---------------------------------------------------------------------------------------
//アイコン一つ
class ColorPickIcon extends ConsumerWidget {
  //色を含んだリスト
  final List<int> RGBColors;

  const ColorPickIcon({super.key,required this.RGBColors});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: (){
        //編集中を解除
        ref.read(onEditiongFlagProvider.notifier).state=false;
        //providerの値を更新
        ref.read(genreInputProvider.notifier).state=ref.read(genreInputProvider).copyWith(
          redValue: RGBColors[0],
          greenValue: RGBColors[1],
          blueValue: RGBColors[2]
        );
        // ref.read(genreInputProvider.notifier).state=ref.read(genreInputProvider).copyWith(greenValue: RGBColors[1]);
        // ref.read(genreInputProvider.notifier).state=ref.read(genreInputProvider).copyWith(blueValue: RGBColors[2]);
        ref.read(genreCorrectInputProvider.notifier).state=ref.read(genreCorrectInputProvider).copyWith(
          redValue: true,
          greenValue: true,
          blueValue: true
        );
        // ref.read(genreCorrectInputProvider.notifier).state=ref.read(genreCorrectInputProvider).copyWith(greenValue: true);
        // ref.read(genreCorrectInputProvider.notifier).state=ref.read(genreCorrectInputProvider).copyWith(blueValue: true);
      },
      icon: Icon(
        ref.read(genreInputProvider.notifier).state.iconData,
        size: 40,
        color: Color.fromARGB(255, RGBColors[0], RGBColors[1], RGBColors[2]),
        )
    );
  }
}

//色入力アイコン---------------------------------------------------------------------------------------
//まとめたやつ
class ColorPickIcons extends ConsumerWidget {
  const ColorPickIcons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
      child: Column(
        children: [
          Center(
            child: Row(
              children: [
                ColorPickIcon(RGBColors: [192,0,0]), //濃い赤
                SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                ColorPickIcon(RGBColors: [255,0,0]), //赤
                SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                ColorPickIcon(RGBColors: [255, 102, 255]), //ピンク
                SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                ColorPickIcon(RGBColors: [255,192,0]), //オレンジ
                SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                ColorPickIcon(RGBColors: [255,255,0]), //黄色
                SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                ColorPickIcon(RGBColors: [146, 208, 80]), //黄緑
              ],
            ),

          ),
          Row(
            children: [
              ColorPickIcon(RGBColors: [0, 176, 80]), //緑
              SizedBox(width: MediaQuery.of(context).size.width*0.01,),
              ColorPickIcon(RGBColors: [0, 176, 240]), //水色
              SizedBox(width: MediaQuery.of(context).size.width*0.01,),
              ColorPickIcon(RGBColors: [0, 112, 192]), //青
              SizedBox(width: MediaQuery.of(context).size.width*0.01,),
              ColorPickIcon(RGBColors: [0, 32, 96]), //濃い青
              SizedBox(width: MediaQuery.of(context).size.width*0.01,),
              ColorPickIcon(RGBColors: [112, 48, 160]), //紫
              SizedBox(width: MediaQuery.of(context).size.width*0.01,),
              ColorPickIcon(RGBColors: [0,0,0]), //黒
            ],
          )
        ],
      ),
    );
  }
}

//形入力アイコン---------------------------------------------------------------------------------------
//アイコン一つ
class ShapePickIcon extends ConsumerWidget {
  //アイコンの形状
  final IconData icon;
  final IconShape iconShape;

  const ShapePickIcon({super.key,required this.icon, required this.iconShape});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: (){
        //providerの中身を更新
        ref.read(genreInputProvider.notifier).state=ref.read(genreInputProvider).copyWith(
          iconData: icon,
          iconShape: iconShape
        );
      },
      icon: Icon(
        icon,
        size: 40,
        color: Color.fromARGB(255, ref.read(genreInputProvider.notifier).state.redValue, ref.read(genreInputProvider.notifier).state.greenValue, ref.read(genreInputProvider.notifier).state.blueValue),
        )
    );
  }
}

//色入力アイコン---------------------------------------------------------------------------------------
//まとめたやつ
class ShapePickIcons extends ConsumerWidget {
  const ShapePickIcons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
        child: Row(
          children: [
            ShapePickIcon(icon: Icons.fiber_manual_record,iconShape: IconShape.circle,), //〇
            SizedBox(width: MediaQuery.of(context).size.width*0.01,),
            ShapePickIcon(icon: Icons.stop,iconShape: IconShape.square,), //■
            SizedBox(width: MediaQuery.of(context).size.width*0.01,),
            ShapePickIcon(icon: Icons.play_arrow_sharp,iconShape: IconShape.triangle,), //▲
            SizedBox(width: MediaQuery.of(context).size.width*0.01,),
            ShapePickIcon(icon: Icons.star,iconShape: IconShape.star,), //☆
            SizedBox(width: MediaQuery.of(context).size.width*0.01,),
            ShapePickIcon(icon: Icons.close,iconShape: IconShape.x,), //✖
            SizedBox(width: MediaQuery.of(context).size.width*0.01,),
            ShapePickIcon(icon: Icons.add,iconShape: IconShape.plus,), //+
          ],
        ),
    );
  }
}