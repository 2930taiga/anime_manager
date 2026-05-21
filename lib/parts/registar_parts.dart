import 'package:anime_administration/models/anime_input_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:anime_administration/models/genre.dart';
import 'package:anime_administration/providers/anime_input_provider.dart';

//-----------------------------------ドロップダウンメニュー--------------------------
class StatusDropDownMenu extends ConsumerWidget {

  const StatusDropDownMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
        child: DropdownMenu(
          label: Text("ステータス"),
          onSelected: (value){ //何かが選ばれたらproviderの値を書き換える 
            if(value==null) return;

            //数値をStatusのenumに変換
            final selectedStatus=Status.values[value];
            //providerを更新
            ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(status: selectedStatus);
            //正しい値が入力されているflagをtrueに
            ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(status: true);
          },
          dropdownMenuEntries: const[
            DropdownMenuEntry(value: 0, label: "未視聴"),
            DropdownMenuEntry(value: 1, label: "視聴中"),
            DropdownMenuEntry(value: 2, label: "視聴済"),
            DropdownMenuEntry(value: 3, label: "視聴中止"),
            DropdownMenuEntry(value: 4, label: "中断"),
          ]
        ),
    );
  }
}

//-----------------------------------タイトル--------------------------
class InputFieldTitle extends ConsumerStatefulWidget {
  const InputFieldTitle({super.key});

  @override
  ConsumerState<InputFieldTitle> createState() => _InputFieldTitleState();
}

class _InputFieldTitleState extends ConsumerState<InputFieldTitle> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
      child: TextField(
        onChanged: (text){
          //入力された文字を判定
          //空白でなければproviderを更新
          if(text!=""){
            ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(title: text);
            setState(() {
              ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(title: true);
            });
          }
          //空白なら警告を出す
          else{
            setState(() {
              ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(title: false);
            });
          }
        },
        decoration: InputDecoration(
          errorText: ref.read(animeCorrectInputProvider.notifier).state.title
          ? null
          : "タイトルを入力してください",
          border: OutlineInputBorder(),
          labelText: "タイトル",
        ),
      ),
    );
  }
}

//-----------------------------------タイトル（かな）--------------------------
class InputFieldTitleKana extends ConsumerStatefulWidget {
  const InputFieldTitleKana({super.key});

  @override
  ConsumerState<InputFieldTitleKana> createState() => _InputFieldTitleKanaState();
}

class _InputFieldTitleKanaState extends ConsumerState<InputFieldTitleKana> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
      child: TextField(
        onChanged: (text){
          //入力された文字を判定
          //空白でなければproviderを更新
          if(text!=""){
            ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(titleKana: text);
            setState(() {
              ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(titleKana: true);
            });
          }
          //空白なら警告を出す
          else{
            setState(() {
              ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(titleKana: false);
            });
          }
        },
        decoration: InputDecoration(
          errorText: ref.read(animeCorrectInputProvider.notifier).state.titleKana
          ? null
          : "タイトル（かな）を入力してください",
          border: OutlineInputBorder(),
          labelText: "タイトル（かな）",
        ),
      ),
    );
  }
}

//-----------------------------------日付入力ボタン--------------------------
class DateInputButtons extends StatelessWidget {
  //テキストコントローラ
  final TextEditingController controller;

  const DateInputButtons({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.44,
            child: ElevatedButton(
              onPressed: (){
                controller.text=inputDateText_today();
                //テキストフィールドのフォーカスを外す
                FocusManager.instance.primaryFocus?.unfocus();
              }, 
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                )
              ),
              child: Text("今日の日付")
              )
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02), //ボタン同士がぴったりくっついてるとダサいので，間隔を開ける
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.44,
            child: ElevatedButton(
              onPressed: () async {
                controller.text = await inputDateText_select(context);
                //テキストフィールドのフォーカスを外す
                FocusManager.instance.primaryFocus?.unfocus();
              }, 
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                )
              ),
              child: Text("日付選択")
              )
          )
        ],
      ),
    );
  }
}

//-----------------------------------日付入力用の関数--------------------------
//今日の日付を入力する関数
String inputDateText_today() {
  //今日の日付を取得
  DateTime date = DateTime.now();
  //日付の見た目をフォーマット
  String FormattedDate = "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";

  return FormattedDate;
}

//カレンダーを表示し，任意の日付を入力する関数
Future<String> inputDateText_select(BuildContext context) async {
  final DateTime? picked = await showDatePicker( //カレンダーを表示して，日付選択画面を出す
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1990),
    lastDate: DateTime(2100)
    );

    //入力された日付を変数に代入
    if (picked != null){
      //入力された日付を代入
      DateTime date= picked;
      //日付の見た目をフォーマット
      String FormattedDate = "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";

      return FormattedDate;
    }

    //もし何も入力されていなければ空白を返す
    return "";
  }

//-----------------------------------ジャンル入力ボタン--------------------------
//選択済ジャンルを表示するText
class SelectedGenreText extends StatefulWidget {
  //データベース
  final Isar isar;
  //ジャンルのリスト
  final List<Genre> genres;

  const SelectedGenreText({super.key,required this.isar, required this.genres});

  @override
  State<SelectedGenreText> createState() => _SelectedGenreTextState();
}

class _SelectedGenreTextState extends State<SelectedGenreText> {
  //選択されているジャンル欄に表示するテキスト
  String select_genre_text="ジャンルが選択されていません";
  //選択されているジャンルのidを保持しておくリストを宣言
  Set<int> selected_genre_id={};

  //ジャンル選択画面を表示させる関数
  Future<void> select_genre(Isar isar, List _genres) async{
    //ボタンの初期状態を読み取る
    //for文が何回回ったかカウントする変数を用意
    int i =0;
    //まずは中身が全てfalseのリストを用意
    List<bool> genre_select_state = List.filled(_genres.length, false);
    //selected_genre_idにそのidが含まれていたらfalse→trueに書き換える
    for (Genre genre_instance in _genres){
      //ジャンルのインスタンスのidが選ばれているジャンルのidを保持するリストに含まれているかを確認
      if(selected_genre_id.contains(genre_instance.id)){
        genre_select_state[i]=true;
      }
      //周回をカウント
      i=i+1;
    }

    showDialog(
      context: context,
      builder: (context){
        return StatefulBuilder(
          builder: (context,setStateDialog){
            return Dialog(
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.9,
                height: 400,
                child: Column(
                  children: [

                    SizedBox(height: 20,),

                    Text(
                      "ジャンルを選択してください",
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),

                    SizedBox(height: 10,),

                    Expanded(
                      child: _genres.isEmpty 
                      ? Center(
                        child: Text(
                          "ジャンルが登録されていません",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey
                          ),
                          ),
                      )
                      : Scrollbar( //ジャンルのリストが空でないならジャンル一覧を表示する
                        thumbVisibility: true,
                        child: ListView(
                          children: List.generate(
                            _genres.length,
                            (index){
                              return SwitchListTile( //スイッチタイル部分
                                title: Text(_genres[index].name),
                                value: genre_select_state[index],
                                onChanged: (bool value){ //あるジャンルが選択されたときの処理
                                  setStateDialog((){
                                    //off→onになったとき
                                    if(value==true){
                                      //選択されているジャンルのidを保持しておくSet内にidを追加
                                      selected_genre_id.add(_genres[index].id);
                                    }
                                    //on→offになったとき
                                    else{
                                      selected_genre_id.remove(_genres[index].id);
                                    }
                                    //ダイアログを呼び出したときに仮で作成したboolのリストの中身を書き換える
                                    genre_select_state[index]=value;
                                  });
                                },
                              );
                            }
                          ),
                        )
                      )
                    ),

                    SizedBox(height: 10,),

                    SizedBox( //保存ボタン
                      width: MediaQuery.of(context).size.width*0.4,
                      child: ElevatedButton(
                        onPressed: (){
                          //ジャンル表示テキストに表示する用のテキストを作成
                          //初期文字列
                          String genre_text_temp="";
                          for(int _id in selected_genre_id){
                            //選択されているジャンルのidから，文字列を作成
                            genre_text_temp += _genres.firstWhere((g) => g.id == _id).name; //データベースのデータをコピーしたリストからidが一致するものを探し出し，nameを取得する
                            //","で区切る
                            genre_text_temp += "，";
                          }

                          //最後の","を取る
                          if(genre_text_temp!=""){
                            genre_text_temp = genre_text_temp.substring(0 , genre_text_temp.length - 1 );
                          }

                          //もし文字列が空白のままなら，「ジャンルが選択されていません」に戻す
                          if(genre_text_temp == ""){
                            genre_text_temp = "ジャンルが選択されていません";
                          }

                          //選択されているジャンルを表示するTextの中身を書き換える
                          setState(() {
                            select_genre_text=genre_text_temp;
                          });
                          
                          //戻る
                          Navigator.pop(context);
                          //テキストのフォーカスを外す
                          FocusScope.of(context).unfocus();
                        },
                        child: Text("保存")
                      ),
                    ),

                    SizedBox(height: 20,)
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 55,
          width: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(7)
          ),
          child: Center(
            child: Text(
              select_genre_text,
              style: TextStyle(
                fontSize: 17
              ),
            ),
          )
          
        ),

        SizedBox(height: 8,), //----------------------------------------

        SizedBox(
          width: MediaQuery.of(context).size.width*0.9,
          child: ElevatedButton(
            onPressed: (){
                select_genre(widget.isar, widget.genres);
            },
            child: Text(
              "ジャンル選択"
            )
          ),
        ),
      ],
    );
  }
}

class InputFieldEpNum extends ConsumerStatefulWidget {
  const InputFieldEpNum({super.key});

  @override
  ConsumerState<InputFieldEpNum> createState() => _InputFieldEpNumState();
}

//-----------------------------------話数入力欄--------------------------
class _InputFieldEpNumState extends ConsumerState<InputFieldEpNum> {
  //コントローラを登録
  final TextEditingController _epNumController = TextEditingController();
  //正しい値が入力されているかどうかを判定するflag
  //あくまでTextFieldにエラーメッセージを表示するかどうかを判定するためのflag．保存時に確認する用ではない
  bool correctInputFlag=true;

  @override
  void dispose(){
    _epNumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width*0.9,
          child: TextField(
            onChanged: (text){
              //入力された値を読み取る
              int? _inputValue = int.tryParse(text);
              //正しい値が入力されているかを判定する
              if(_inputValue!=null){ //正しい
                ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(epNum: int.tryParse(text));
                setState(() {
                  ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epNum: true);
                });
              }
              else{ //正しくない
                setState(() {
                  ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epNum: false);
                });
              }
            },
            controller: _epNumController,
            decoration: InputDecoration(
              errorText: ref.read(animeCorrectInputProvider.notifier).state.epNum
              ? null
              : "正しい値を入力してください",
              border: OutlineInputBorder(),
              labelText: "話数",
            ),
          ),
        ),

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2866666,
                child: ElevatedButton(
                  onPressed: (){
                    //TextFieldのフォーカスを外す
                    FocusManager.instance.primaryFocus?.unfocus();
                    //providerの値を変更
                    ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(epNum: 12);
                    //コントローラの中身を変える
                    _epNumController.text="12";
                    //ボタンを押すと必ず正しい値が入るので，flagをtrueにする
                    setState(() {
                      ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epNum: true);
                    });
                  }, 
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                  child: Text("12話")
                  )
              ),

              SizedBox(width: MediaQuery.of(context).size.width * 0.02), //ボタン同士がぴったりくっついてるとダサいので，間隔を開ける

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2866666,
                child: ElevatedButton(
                  onPressed: (){
                    //TextFieldのフォーカスを外す
                    FocusManager.instance.primaryFocus?.unfocus();
                    //providerの値を変更
                    ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(epNum: 24);
                    //コントローラの中身を変える
                    _epNumController.text="24";
                    //ボタンを押すと必ず正しい値が入るので，flagをtrueにする
                    setState(() {
                      ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epNum: true);
                    });
                  }, 
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                  child: Text("24話")
                  )
              ),

              SizedBox(width: MediaQuery.of(context).size.width * 0.02), //ボタン同士がぴったりくっついてるとダサいので，間隔を開ける

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2866666,
                child: ElevatedButton(
                  onPressed: () async{
                    final result = (await inputEpNum(context)).toString();
                    if(result!="null"){
                      //providerの値を変更
                      ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(epNum: int.tryParse(result));
                      //コントローラの中身を変える
                      _epNumController.text=result.toString();
                      //ボタンを押すと必ず正しい値が入るので，flagをtrueにする
                      setState(() {
                        ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epNum: true);
                      });
                    }
                  }, 
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                  child: Text("話数選択")
                  )
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//-----------------------------------話数入力用の関数--------------------------
//ボタンを押すと，話数選択のスロットを表示する関数を宣言
Future<int?> inputEpNum(BuildContext context) async{
  int _pickerSelected_EpNum=0;

  return await showModalBottomSheet<int>(
    context: context, 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(0) //下から出てくるやつの角を四角くする
    ),
    builder: (context){
      return Container(
        width: MediaQuery.of(context).size.width*1.0,
        height: 250,
        child: Column(
          children: [
            SizedBox( //上部に出す「キャンセル」，「タイトル」，「決定」のボタン
              height: 50,
              width: MediaQuery.of(context).size.width*1.0,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.23,
                        child: Center(
                          child: TextButton( //話数選択画面のキャンセルボタン
                            onPressed:(){
                              //ボタン選択時点での入力を保持しておく
                              Navigator.of(context).pop(); //画面を戻る
                              FocusManager.instance.primaryFocus?.unfocus(); //テキストのフォーカスを外す
                            },
                            child: Text(
                              "キャンセル",
                              style: TextStyle(
                                color: Colors.blue
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.57,
                        child: Center(
                          child: Text( //話数選択画面の上部のテキスト
                            "話数選択",
                            style: TextStyle(
                              fontSize: 20
                            ),
                            ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.2,
                        child: Center(
                          child: TextButton( //話数選択画面の保存ボタン
                            onPressed: (){
                              Navigator.pop(context,_pickerSelected_EpNum); //前の画面に戻りつつ，値を返す
                              FocusManager.instance.primaryFocus?.unfocus(); //テキストのフォーカスを外す
                              //print("保存された");
                            },
                            child: Text(
                              "保存",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              height: 110,
              width: MediaQuery.of(context).size.width*0.7,
              child: CupertinoPicker(
                itemExtent: 40,
                onSelectedItemChanged: (index){
                  _pickerSelected_EpNum=index;
                },
                children: List.generate(10000,(index){
                  return Center(
                    child: Text(
                      "${index}"
                    ),
                  );
                })
              ),
            ),
          ],
        ),
      );
    }
  );
}

//-----------------------------------時間入力用のTextField--------------------------
class InputFieldEpTime extends ConsumerStatefulWidget {
  const InputFieldEpTime({super.key});

  @override
  ConsumerState<InputFieldEpTime> createState() => _InputFieldEpTimeState();
}

class _InputFieldEpTimeState extends ConsumerState<InputFieldEpTime> {
  //テキストコントローラを作成
  final TextEditingController _epTimeController = TextEditingController();
  //正しい値が入力されているかどうかを判定するflag
  //あくまでTextFieldにエラーメッセージを表示するかどうかを判定するためのflag．保存時に確認する用ではない
  bool correctInputFlag=true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width*0.9,
          child: TextField(
            onChanged: (text){
              //入力された値 を読み取る
                if(int.tryParse(text)==null){ //正しくない
                  setState(() {
                    ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epTime: false);
                  });
                }
                else{ //正しい
                  setState(() {
                    ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epTime: true);
                  });
                }
              },
            controller: _epTimeController,
            decoration: InputDecoration(
              errorText: ref.read(animeCorrectInputProvider.notifier).state.epTime
              ? null
              : "正しい値を入力してください",
              border: OutlineInputBorder(),
              labelText: "1話あたりの時間(分)",
            ),
          ),
        ),

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2866666,
                child: ElevatedButton(
                  onPressed: (){
                    _epTimeController.text = "24";
                    //providerの値を書き換える
                    ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(epTime: 24);
                    //ボタンを押すと必ず正しい値が入るので，flagをtrueにする
                    setState(() {
                      ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epTime: true);
                    });
                  }, 
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                  child: Text("24分")
                  )
              ),

              SizedBox(width: MediaQuery.of(context).size.width * 0.02), //ボタン同士がぴったりくっついてるとダサいので，間隔を開ける

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2866666,
                child: ElevatedButton(
                  onPressed: (){
                    _epTimeController.text = "12";
                    //providerの値を書き換える
                    ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(epTime: 12);
                    //ボタンを押すと必ず正しい値が入るので，flagをtrueにする
                    setState(() {
                      ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epTime: true);
                    });
                  }, 
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                  child: Text("12分")
                  )
              ),

              SizedBox(width: MediaQuery.of(context).size.width * 0.02), //ボタン同士がぴったりくっついてるとダサいので，間隔を開ける

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2866666,
                child: ElevatedButton(
                  onPressed: ()async {
                    //入力時点での入力値を保持しておく
                    String text_temp=_epTimeController.text;
                    final result=await inputEpTime(context);
                    if(result !=null){
                      _epTimeController.text=result;
                      //providerの値を書き換える
                      ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(epTime: int.tryParse(result));
                      //ボタンを押すと必ず正しい値が入るので，flagをtrueにする
                      setState(() {
                        ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epTime: true);
                      });
                    }
                    else{
                      _epTimeController.text=text_temp;
                    }
                  }, 
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                  child: Text("時間選択")
                  )
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//-----------------------------------時間入力用の関数--------------------------
//ボタンを押すと時間入力のスロットを表示する関数を宣言
Future<String?> inputEpTime(BuildContext context) async{
  //選択されている数値を保持する変数
  int _pickerSelected_Hour = 0;
  int _pickerSelected_Min = 0;
  //値がnullにならないための初期変数
  String _pickerSelected_text = "0:00";
  return await showModalBottomSheet<String>(
    context: context, 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(0) //下から出てくるやつの角を四角くする
    ),
    builder: (context){
      return Container(
        width: MediaQuery.of(context).size.width*1.0,
        height: 250,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(0)
        // ),
        child: Column(
          children: [
            SizedBox( //上部に出す「キャンセル」，「タイトル」，「決定」のボタン
              height: 50,
              width: MediaQuery.of(context).size.width*1.0,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.23,
                        child: Center(
                          child: TextButton( //時間選択画面のキャンセルボタン部分
                            onPressed:(){
                              Navigator.of(context,).pop(); //画面を戻る
                              FocusManager.instance.primaryFocus?.unfocus(); //テキストのフォーカスを外す
                            },
                            child: Text(
                              "キャンセル",
                              style: TextStyle(
                                color: Colors.blue
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.57,
                        child: Center(
                          child: Text( //時間選択画面上部のテキスト部分
                            "時間選択",
                            style: TextStyle(
                              fontSize: 20
                            ),
                            ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.2,
                        child: Center(
                          child: TextButton( //時間選択画面の保存ボタン部分
                            onPressed: (){
                              _pickerSelected_text = (_pickerSelected_Hour*60 + _pickerSelected_Min).toString();
                              Navigator.pop(context,_pickerSelected_text); //画面を戻りつつ，値を返す
                              FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
                            },
                            child: Text(
                              "保存",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              height: 110,
              width: MediaQuery.of(context).size.width*0.7,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.3,
                    child: CupertinoPicker( //時間選択の「時間」部分
                      itemExtent: 40,
                      onSelectedItemChanged: (index){
                        //時間が選ばれるたびに変数を更新する
                        _pickerSelected_Hour=index;
                      },
                      children: List.generate(100,(index){
                        return Center(
                          child: Text(
                            "${index}"
                          ),
                        );
                      })
                    ),
                  ),
                  SizedBox(
                    width:  MediaQuery.of(context).size.width*0.1,
                    child: Center(
                      child: Text(
                        ":",
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.3,
                    child: CupertinoPicker( //時間選択の「分数」部分
                      itemExtent: 40,
                      onSelectedItemChanged: (index){
                        //分数が選ばれるたびに変数を更新する
                        _pickerSelected_Min=index;
                      },
                      children: List.generate(60,(index){
                        return Center(
                          child: Text(
                            "${index}"
                          ),
                        );
                      })
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  );
}


//-----------------------------------評価入力用の関数--------------------------
class EvaluationIcons extends ConsumerStatefulWidget {
  const EvaluationIcons({super.key});

  @override
  ConsumerState<EvaluationIcons> createState() => _EvaluationIconsState();
}

class _EvaluationIconsState extends ConsumerState<EvaluationIcons> {
  //初期値を宣言
  int _evaluation=0;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, //中央寄せにする
        children: [
          Text(
            "評価",
            style: TextStyle(
              fontSize: 16
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width*0.05,),
          IconButton( //評価1
            onPressed: (){
              FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
              setState(() {
                _evaluation=1;
              });
              //providerの評価を書き換える
              ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(evaluation: _evaluation);
              //正しく入力されているflagをtrueに
              ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(evaluation: true);
            },
            icon: const Icon(Icons.star),
            iconSize: 35,
            color:_evaluation>=1? Color.fromARGB(255, 255, 217, 0):Colors.grey,
          ),
          IconButton( //評価2
            onPressed: (){
              FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
              setState(() {
                _evaluation=2;
              });
              //providerの評価を書き換える
              ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(evaluation: _evaluation);
              //正しく入力されているflagをtrueに
              ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(evaluation: true);
            },
            icon: const Icon(Icons.star),
            iconSize: 35,
            color:_evaluation>=2? Color.fromARGB(255, 255, 217, 0):Colors.grey,
          ),
          IconButton( //評価3
            onPressed: (){
              FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
              setState(() {
                _evaluation=3;
              });
              //providerの評価を書き換える
              ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(evaluation: _evaluation);
              //正しく入力されているflagをtrueに
              ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(evaluation: true);
            },
            icon: const Icon(Icons.star),
            iconSize: 35,
            color:_evaluation>=3? Color.fromARGB(255, 255, 217, 0):Colors.grey,
          ),
          IconButton( //評価4
            onPressed: (){
              FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
              setState(() {
                _evaluation=4;
              });
              //providerの評価を書き換える
              ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(evaluation: _evaluation);
              //正しく入力されているflagをtrueに
              ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(evaluation: true);
            },
            icon: const Icon(Icons.star),
            iconSize: 35,
            color:_evaluation>=4? Color.fromARGB(255, 255, 217, 0):Colors.grey,
          ),
          IconButton( //評価5
            onPressed: (){
              FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
              setState(() {
                _evaluation=5;
              });
              //providerの評価を書き換える
              ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(evaluation: _evaluation);
              //正しく入力されているflagをtrueに
              ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(evaluation: true);
            },
            icon: const Icon(Icons.star),
            iconSize: 35,
            color:_evaluation>=5? Color.fromARGB(255, 255, 217, 0):Colors.grey,
          ),
        ],
      ),
    );
  }
}

//-----------------------------------メモ--------------------------
//改行ができる
class InputFieldMemo extends ConsumerWidget {
  const InputFieldMemo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
      //height: 60,
      child: TextField(
        onChanged: (text){
          ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(memo: text);
        },
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "メモ",
        ),
      ),
    );
  }
}