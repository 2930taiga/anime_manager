import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//-----------------------------------TextField--------------------------
class InputField extends StatelessWidget {
  //入力フォームに表示するラベル
  final String label;
  //テキストコントローラ
  final TextEditingController controller;

  const InputField({
    super.key,
    required this.label,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
      height: 60,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
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

//-----------------------------------話数入力ボタン--------------------------
class EpNumInputButtons extends StatelessWidget {
  //テキストコントローラを登録
  final TextEditingController controller;

  const EpNumInputButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2866666,
            child: ElevatedButton(
              onPressed: (){
                controller.text="12";
                //TextFieldのフォーカスを外す
                FocusManager.instance.primaryFocus?.unfocus();
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
                controller.text="24";
                //TextFieldのフォーカスを外す
                FocusManager.instance.primaryFocus?.unfocus();
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
                //ボタン選択時の入力を保持しておく
                String text_temp=controller.text;
                final result = (await inputEpNum(context)).toString();
                if(result!="null"){
                  controller.text=result;
                }
                else{
                  controller.text=text_temp;
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
                children: List.generate(100,(index){
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

//-----------------------------------時間入力用の関数--------------------------
class EpTimeInputButtons extends StatelessWidget {
  //テキストコントローラを登録
  final TextEditingController controller;

  const EpTimeInputButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2866666,
            child: ElevatedButton(
              onPressed: (){
                controller.text = inputEpTimeText(0, 24);
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
                controller.text = inputEpTimeText(0, 12);
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
                String text_temp=controller.text;
                final result=await inputEpTime(context);
                if(result !=null){
                  controller.text=result;
                }
                else{
                  controller.text=text_temp;
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
                              _pickerSelected_text = inputEpTimeText(_pickerSelected_Hour,_pickerSelected_Min);
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

//-----------------------------------時間入力用の関数--------------------------
//任意の時間（時:分）を自動で入力する関数を宣言
  String inputEpTimeText(int epHour, int epMin){
    return "${epHour}:${epMin.toString().padLeft(2,"0")}"; //話数を自動で入力する
  }


//-----------------------------------評価入力用の関数--------------------------
class EvaluationIcons extends StatefulWidget {
  const EvaluationIcons({super.key});

  @override
  State<EvaluationIcons> createState() => _EvaluationIconsState();
}

class _EvaluationIconsState extends State<EvaluationIcons> {
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
            },
            icon: Icon(Icons.star),
            iconSize: 35,
            color:_evaluation>=1? Color.fromARGB(255, 255, 217, 0):Colors.grey,
          ),
          IconButton( //評価2
            onPressed: (){
              FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
              setState(() {
                _evaluation=2;
              });
            },
            icon: Icon(Icons.star),
            iconSize: 35,
            color:_evaluation>=2? Color.fromARGB(255, 255, 217, 0):Colors.grey,
          ),
          IconButton( //評価3
            onPressed: (){
              FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
              setState(() {
                _evaluation=3;
              });
            },
            icon: Icon(Icons.star),
            iconSize: 35,
            color:_evaluation>=3? Color.fromARGB(255, 255, 217, 0):Colors.grey,
          ),
          IconButton( //評価4
            onPressed: (){
              FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
              setState(() {
                _evaluation=4;
              });
            },
            icon: Icon(Icons.star),
            iconSize: 35,
            color:_evaluation>=4? Color.fromARGB(255, 255, 217, 0):Colors.grey,
          ),
          IconButton( //評価5
            onPressed: (){
              FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
              setState(() {
                _evaluation=5;
              });
            },
            icon: Icon(Icons.star),
            iconSize: 35,
            color:_evaluation>=5? Color.fromARGB(255, 255, 217, 0):Colors.grey,
          ),
        ],
      ),
    );
  }
}