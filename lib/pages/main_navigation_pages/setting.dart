import 'package:flutter/material.dart'; // これがないとWidgetが使えない

//ジャンルに関する設定ページ
import 'setting/genre/genre.dart';

//設定ページ
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

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
          SizedBox(height: 7,),

          ListTile(
            leading: Icon(Icons.settings),
            trailing: Icon(Icons.chevron_right),
            title: Text(
              "一般",
              style: TextStyle(
                fontSize: 18
              ),
            ),
            onTap: (){},
            minTileHeight: 50,
          ),

          Divider(),

          Center(
            child: ListTile(
              leading: Icon(Icons.view_week_outlined),
              trailing: Icon(Icons.chevron_right),
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
                    builder: (content) => SettingGenre()
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
              trailing: Icon(Icons.chevron_right),
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
              trailing: Icon(Icons.chevron_right),
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