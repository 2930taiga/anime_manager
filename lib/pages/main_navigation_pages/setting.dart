import 'package:anime_administration/pages/main_navigation_pages/setting/backup/backup_navigation.dart';
import 'package:anime_administration/pages/main_navigation_pages/setting/delete_all.dart';
import 'package:anime_administration/parameter_settings.dart';
import 'package:anime_administration/parts/setting_parts.dart';
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

          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 15,
              vertical: 8
            ),
            child: GestureDetector(
              onTap: (){
                showErrorSnackBar(context, "未実装機能です");
              },
              child: SettingCard(
                icon: Icons.settings_outlined,
                iconColor: SettingCardColors.cardColors[0],
                titleText: "一般",
                subText: "アプリ全般の設定"
              ),
            ),
          ),


          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 15,
              vertical: 8
            ),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (content) => SettingGenre()
                  )
                );
              },
              child: SettingCard(
                icon: Icons.view_week_outlined,
                iconColor: SettingCardColors.cardColors[1],
                titleText: "ジャンル",
                subText: "ジャンル関連の設定"
              ),
            ),
          ),

          
          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 15,
              vertical: 8
            ),
            child: GestureDetector(
              onTap: (){
                showErrorSnackBar(context, "未実装機能です");
              },
              child: SettingCard(
                icon: Icons.palette_outlined,
                iconColor: SettingCardColors.cardColors[2],
                titleText: "テーマカラー",
                subText: "テーマカラーを設定"
              ),
            ),
          ),


          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 15,
              vertical: 8
            ),
            child: GestureDetector(
              onTap: (){
                showErrorSnackBar(context, "未実装機能です");
              },
              child: SettingCard(
                icon: Icons.abc_outlined,
                iconColor: SettingCardColors.cardColors[3],
                titleText: "文字サイズ",
                subText: "文字サイズを設定"
              ),
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 15,
              vertical: 8
            ),
            child: GestureDetector(
              onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (content) => BackupNavigationPage()
                )
              );
            },
              child: SettingCard(
                icon: Icons.cloud_upload_outlined,
                iconColor: SettingCardColors.cardColors[4],
                titleText: "バックアップ",
                subText: "データのバックアップ・復元"
              ),
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 15,
              vertical: 8
            ),
            child: GestureDetector(
              onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (content) => DeleteNavigationPage(context: content)
                )
              );
            },
              child: SettingDeleteCard(
                icon: Icons.delete_forever_outlined,
                iconColor: Colors.red,
                titleText: "データ消去",
                subText: "全てのデータを消去する"
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}