import 'package:anime_administration/pages/main_navigation_pages/setting/backup/backup.dart';
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
              ListTile(
                leading: Icon(Icons.backup_outlined),
                title: Text("データをバックアップする"),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (content) => UploadNavigationPage()
                    )
                  );
                },
              ),

              Divider(),

              ListTile(
                leading: Icon(Icons.cloud_download_outlined),
                title: Text("バックアップファイルから復元する"),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  
                },
              ),

              Divider()
            ],
          )
        )
      ),
    );
  }
}