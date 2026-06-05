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

//ステータスカラー
class StatusColors{
  static List<Color> boxColors = [
    Color.fromARGB(255, 245, 245, 245), //未視聴
    Color.fromARGB(255, 232, 245, 233), //視聴中
    Color.fromARGB(255, 227, 242, 253), //視聴済み
    Color.fromARGB(255, 255, 235, 238), //視聴中止
    Color.fromARGB(255, 255, 248, 225), //視聴中断
  ];

  static List<Color> textColors = [
    Color.fromARGB(255, 97, 97, 97), //未視聴
    Color.fromARGB(255, 46, 125, 50), //視聴中
    Color.fromARGB(255, 21, 101, 192), //視聴済み
    Color.fromARGB(255, 198, 40, 40), //視聴中止
    Color.fromARGB(255, 183, 129, 3), //視聴中断
  ];
}

//スナックバー表示関数
void showSnackBar(BuildContext context,String text){
  ScaffoldMessenger.of(context).showSnackBar( //スナックバーにメッセージを表示
    SnackBar(
      duration: const Duration(milliseconds: 1500), //表示時間を設定
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