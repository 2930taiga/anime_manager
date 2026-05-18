import 'package:flutter/material.dart'; // これがないとWidgetが使えない
import 'package:isar/isar.dart';

//ジャンルに関する設定ページ
import 'setting/genre.dart';

//設定ページ
class SettingPage extends StatefulWidget {
  //Isarを保持するための変数を宣言
  final Isar isar;
  //コンストラクタを設定（isarを必須にする）
  const SettingPage({super.key,required this.isar});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>{

  @override
  Widget build(BuildContext content){
    return Scaffold(
      appBar: AppBar(
        title: Text("設定"),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: ListView(
        children: [
          Center(
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                "一般",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
              onTap: (){},
              minTileHeight: 50,
            ),
          ),

          Divider(),

          Center(
            child: ListTile(
              leading: Icon(Icons.view_week_outlined),
              title: Text(
                "ジャンル",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
              onTap: (){ //ジャンルに関する設定を表示
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (content) => SettingGenre(isar: widget.isar)
                  )
                );
              },
              minTileHeight: 50,
            ),
          ),

          Divider(),

          Center(
            child: ListTile(
              leading: Icon(Icons.palette_outlined),
              title: Text(
                "テーマカラー",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
              onTap: (){},
              minTileHeight: 50,
            ),
          ),

          Divider(),

          Center(
            child: ListTile(
              leading: Icon(Icons.abc),
              title: Text(
                "文字サイズ",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
              onTap: (){},
              minTileHeight: 50,
            ),
          ),

          Divider(),
        ],
      ),
    );
  }
}