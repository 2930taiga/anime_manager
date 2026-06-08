import 'package:anime_administration/models/anime.dart';
import 'package:anime_administration/models/genre.dart';
import 'package:anime_administration/parameter_settings.dart';
import 'package:anime_administration/providers/isar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
//設定のパーツ
import 'package:anime_administration/parts/setting_parts.dart';
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
                      builder: (content) => UploadCsvPage()
                    )
                  );
                },
                child: SettingCard(
                  icon: Icons.document_scanner_outlined,
                  iconColor: Colors.deepOrange,
                  titleText: "CSV",
                  subText: "CSVファイルでバックアップする"
                ),
              ),
            ),

            // ListTile(
            //   leading: Icon(Icons.backup_outlined),
            //   title: Text("CSVファイルでバックアップする"),
            //   trailing: Icon(Icons.chevron_right),
            //   onTap: (){
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (content) => UploadCsvPage()
            //       )
            //     );
            //   },
            // ),

            //Divider(),

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
                      builder: (content) => UploadJsonPage()
                    )
                  );
                },
                child: SettingCard(
                  icon: Icons.dock_outlined,
                  iconColor: Colors.lightBlue,
                  titleText: "JSON",
                  subText: "JSONファイルでバックアップする"
                ),
              ),
            ),

            // ListTile(
            //   leading: Icon(Icons.cloud_download_outlined),
            //   title: Text("JSONファイルでバックアップする"),
            //   trailing: Icon(Icons.chevron_right),
            //   onTap: (){
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (content) => UploadJsonPage()
            //       )
            //     );
            //   },
            // ),

            //Divider()
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
  //アニメ
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

  String csv = const ListToCsvConverter().convert(rows);

  final file = File("${dir.path}/anime.csv");

  await file.writeAsString(csv);

  return file;
}


  //CSVにデータを書き込んで保存する関数
  //ジャンル
  Future<File> exportGenreCsv(
  Isar isar,
  Directory dir,
  ) async {

  final genres = await isar.genres.where().findAll();

  List<List<dynamic>> rows = [];

  rows.add([
    "id",
    "name",
    "red",
    "green",
    "blue",
    "iconShape"
  ]);

  for(final genre in genres){
    rows.add([
      genre.id,
      genre.name,
      genre.redValue,
      genre.greenValue,
      genre.blueValue,
      genre.iconShape.name
    ]);
  }

  String csv = const ListToCsvConverter().convert(rows);

  final file = File("${dir.path}/genre.csv");

  await file.writeAsString(csv);

  return file;
  }


  //CSVにデータを書き込んで保存する関数
  //リンク
  Future<File> exportLinkCsv(
  Isar isar,
  Directory dir,
  ) async {

  final animes = await isar.animes.where().findAll();

  List<List<dynamic>> rows = [];

  rows.add([
    "animeId",
    "genreId"
  ]);

  for(final anime in animes){

    await anime.genres.load();

    for(final genre in anime.genres){

      rows.add([
        anime.id,
        genre.id
      ]);
    }
  }

  String csv = const ListToCsvConverter().convert(rows);

  final file = File("${dir.path}/link.csv");

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
              
              //保存先（一時ディレクトリ）を取得
              final dir = await getTemporaryDirectory();

              //ファイルを内部ストレージに保存
              final animeFile = await exportAnimeCsv(
                ref.read(isarProvider),
                dir,
              );
              final genreFile = await exportGenreCsv(
                ref.read(isarProvider),
                dir,
              );
              final linkFile = await exportLinkCsv(
                ref.read(isarProvider),
                dir,
              );

              //ファイルを共有する
              await SharePlus.instance.share(
                ShareParams(
                  files: [
                    XFile(animeFile.path),
                    XFile(genreFile.path),
                    XFile(linkFile.path),
                  ],
                  text: "アニメファイルのバックアップ",
                )
              );

              showSnackBar(context,"ファイルを保存しました");
            }

            catch(e){
              showErrorSnackBar(context, "保存時にエラーが発生しました．デバッグモードで確認してください");
            }
          },
          child: Text("ファイルを保存")
        ),
      ),
    );
  }
}

class UploadJsonPage extends StatelessWidget {
  const UploadJsonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back)
        ),
        title: Text("JSONでバックアップ"),
      ),

      body: Center(
        child: Text(
          "Coming Soon...",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20
          ),
        ),
      ),
    );
    
  }
}