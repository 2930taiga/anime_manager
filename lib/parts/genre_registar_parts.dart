import 'package:flutter/material.dart';
//providerに関するものをインポート
import 'package:flutter_riverpod/flutter_riverpod.dart';
//providerの定義に関するスクリプトをインポート
import 'package:anime_administration/pages/main_navigation_pages/setting/genre_registar.dart';

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

//色入力欄---------------------------------------------------------------------------------------
//赤---------------------------------------------------------------------------------------
class RedInputField extends ConsumerStatefulWidget {
  const RedInputField({super.key});

  @override
  ConsumerState<RedInputField> createState() => _RedInputFieldState();
}

class _RedInputFieldState extends ConsumerState<RedInputField> {
  //テキストコントローラを登録
  final TextEditingController _redController = TextEditingController();
  //メモリ解放
  @override
  void dispose(){
    _redController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row( //-------Red
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
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
                          //テキストフィールドの値を更新
                          _redController.text=index.toInt().toString();
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
            controller: _redController,
            onChanged: (text){
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
  //テキストコントローラを登録
  final TextEditingController _greenController = TextEditingController();
  //メモリ解放
  @override
  void dispose(){
    _greenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row( //-------Green
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
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
                          //テキストフィールドの値を更新
                          _greenController.text=index.toInt().toString();
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
            controller: _greenController,
            onChanged: (text){
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
  //テキストコントローラを登録
  final TextEditingController _blueController = TextEditingController();
  //メモリ解放
  @override
  void dispose(){
    _blueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row( //-------Red
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
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
                          //テキストフィールドの値を更新
                          _blueController.text=index.toInt().toString();
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
            controller: _blueController,
            onChanged: (text){
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