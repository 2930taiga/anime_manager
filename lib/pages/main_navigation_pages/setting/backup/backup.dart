import 'package:anime_administration/models/anime.dart';
import 'package:anime_administration/models/genre.dart';
import 'package:anime_administration/parameter_settings.dart';
import 'package:anime_administration/providers/isar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
//csv出力に必要なパッケージ
import 'dart:io';
import 'package:csv/csv.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class UploadNavigationPage extends StatelessWidget {
  const UploadNavigationPage({super.key});

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

        title: Text("データのバックアップ"),

      ),

      body: Scrollbar(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.backup_outlined),
              title: Text("CSVファイルでバックアップする"),
              trailing: Icon(Icons.chevron_right),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (content) => UploadCsvPage()
                  )
                );
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.cloud_download_outlined),
              title: Text("JSONファイルでバックアップする"),
              trailing: Icon(Icons.chevron_right),
              onTap: (){
                
              },
            ),

            Divider()
          ],
        )
      )
    );
  }
}

class UploadCsvPage extends ConsumerStatefulWidget {
  const UploadCsvPage({super.key});

  @override
  ConsumerState<UploadCsvPage> createState() => _UploadCsvPageState();
}

class _UploadCsvPageState extends ConsumerState<UploadCsvPage> {

  //CSVにデータを書き込んで保存する関数
  Future<File> exportAnimeCsv(
  Isar isar,
  Directory dir,
  ) async {

  final animes = await isar.animes.where().findAll();

  List<List<dynamic>> rows = [];

  rows.add([
    "id",
    "status",
    "title",
    "titleKana",
    "date",
    "onAirYear",
    "season",
    "epNum",
    "epTime",
    "evaluation",
    "memo"
  ]);

  for(final anime in animes){
    rows.add([
      anime.id,
      anime.status.name,
      anime.title,
      anime.titleKana,
      anime.date.toIso8601String(),
      anime.onAirYear,
      anime.season.name,
      anime.epNum,
      anime.epTime,
      anime.evaluation,
      anime.memo
    ]);
  }

  String csv =
      const ListToCsvConverter().convert(rows);

  final file =
      File("${dir.path}/anime.csv");

  await file.writeAsString(csv);

  return file;
}


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

        title: Text("CSVでバックアップ"),
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            //保存ダイアログを表示する
            try{
              // String? outputPath = await FilePicker.platform.getDirectoryPath(
              //   dialogTitle: "保存先のフォルダを指定してください",
              // );
              // //フォルダが選ばれなかった
              // if(outputPath==null){
              //   print("フォルダが選ばれませんでした");
              //   showSnackBar(context, "フォルダが選ばれませんでした");
              //   return;
              // }

              // print("保存先：$outputPath");

              // //フォルダが選ばれた
              // exportAnimeCsv(ref.read(isarProvider), Directory(outputPath));
              

              final dir = await getApplicationDocumentsDirectory();

              final file = await exportAnimeCsv(
                ref.read(isarProvider),
                dir,
              );

              await Share.shareXFiles(
                [XFile(file.path)],
                text: "アニメ管理アプリのバックアップ",
              );

              exportAnimeCsv(ref.read(isarProvider), dir);
            }
            catch(e){
              print("保存エラー");
              showSnackBar(context, "保存時にエラーが発生しました．デバッグモードで確認してください");
            }
          },
          child: Text("ファイルを保存")
        ),
      ),
    );
  }
}