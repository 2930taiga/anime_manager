import 'package:anime_administration/pages/main_navigation_pages/setting/backup/backup.dart';
import 'package:anime_administration/parameter_settings.dart';
import 'package:anime_administration/parts/setting_parts.dart';
import 'package:flutter/material.dart';

class BackupNavigationPage extends StatelessWidget {
  const BackupNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: IconButton( //戻るボタン
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back)
        ),

        title: Text("データのバックアップ・復元"),

      ),

      body: Expanded(
        child: Scrollbar(
          child: ListView(
            children: [

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
                        builder: (content) => UploadNavigationPage()
                      )
                    );
                  },
                  child: SettingCard(
                    icon: Icons.backup_outlined,
                    iconColor: SettingCardColors.cardColors[0],
                    titleText: "バックアップ",
                    subText: "データをバックアップする"
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
                    
                  },
                  child: SettingCard(
                    icon: Icons.cloud_download_outlined,
                    iconColor: SettingCardColors.cardColors[1],
                    titleText: "復元",
                    subText: "バックアップファイルから復元する"
                  ),
                ),
              ),

            ],
          )
        )
      ),
    );
  }
}