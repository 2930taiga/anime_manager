import 'package:flutter/material.dart';

//ボタン系
class ElevatedButtons{
  //テキストの色
  static Color fontColor = Color.fromARGB(255, 255, 255, 255);
  //ボタンの背景色
  static Color backgroundColor = Color.fromARGB(255, 7, 125, 223);

  //キャンセルボタンのテキストカラー
  static Color cancelFontColor = Colors.black;
  //キャンセルボタンの背景色
  static Color cancelButtonBackgroundColor = Colors.white;
}

//テキスト系
class Texts{
  //エラーメッセージ
  static Color errorMessageColor = Colors.red;
  //サブメッセージ
  static Color subMessageColor = Color.fromARGB(255, 109, 109, 109);
}

//スナックバー表示関数
void showSnackBar(BuildContext context,String text){
  ScaffoldMessenger.of(context).showSnackBar( //スナックバーにメッセージを表示
    SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)), //角丸
      behavior: SnackBarBehavior.floating, //浮いた感じに
      backgroundColor: Colors.white, //背景を白に
      content: Row(
        children: [
          Icon( //チェックマーク
            Icons.check,
            color: Colors.green,
          ),

          SizedBox(width: MediaQuery.of(context).size.width*0.02,),

          Expanded(
            child: Text( //テキスト
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14
              ),
            )
          )
        ],
      )
    )
  );
}