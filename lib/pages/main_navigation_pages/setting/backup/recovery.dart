import 'dart:io';
import 'package:anime_administration/models/anime.dart';
import 'package:anime_administration/models/genre.dart';
import 'package:anime_administration/parameter_settings.dart';
import 'package:anime_administration/parts/setting_parts.dart';
import 'package:anime_administration/providers/isar_provider.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:anime_administration/models/genre.dart';

class RecoveryNavigationPage extends StatelessWidget {
  const RecoveryNavigationPage({super.key});

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
        title: Text("データの復元"),
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
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (content) => RecoveryCsvPage()
                      )
                    );
              },
              child: SettingCard(
                icon: Icons.cloud_download_outlined,
                iconColor: SettingCardColors.cardColors[0],
                titleText: "CSV",
                subText: "CSVファイルから復元する"
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
                icon: Icons.cloud_download_outlined,
                iconColor: SettingCardColors.cardColors[1],
                titleText: "JSON",
                subText: "JSONファイルから復元する"
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecoveryCsvPage extends ConsumerStatefulWidget {
  const RecoveryCsvPage({super.key});

  @override
  ConsumerState<RecoveryCsvPage> createState() => _RecoveryCsvPageState();
}

class _RecoveryCsvPageState extends ConsumerState<RecoveryCsvPage> {
  //削除時に確認のアラートを出す関数
  Future<bool> confirmDeleteDialog() async {
    final result = await showDialog<bool>(context: context,
      builder: (_){
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            height: 280,
            child: Column(
              children: [
                SizedBox(height: 20,),

                Text( //タイトル
                  "確認",
                  style: TextStyle(
                    fontSize: 27,
                    color: Texts.errorMessageColor,
                    fontWeight: FontWeight.bold
                  ),
                ),

                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 30,
                    vertical: 30
                  ),
                  child: Column(
                    children: [
                      Text(
                        "データを全て消去しますか？",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Texts.subMessageColor,
                          fontSize: 17
                        ),
                      ),
                      Text(
                        "\nこの操作は取り消せません！",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 5
                  ),
                  child: Row( //OK．キャンセルボタン
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.30,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (){
                              showErrorSnackBar(context, "操作が取り消されました");
                              //falseを返す
                              Navigator.of(context).pop(false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ElevatedButtons.cancelButtonBackgroundColor,
                              padding: EdgeInsets.symmetric(horizontal: 2) //余白を小さくする
                            ),
                            child: Text(
                              "キャンセル",
                              style: TextStyle(
                                color: ElevatedButtons.cancelFontColor,
                                fontSize: 15
                              ),
                            )
                          ),
                        ),

                        SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                        
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.30,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ElevatedButtons.backgroundColor
                            ),
                            child: Text(
                              "OK",
                              style: TextStyle(
                                color: ElevatedButtons.fontColor,
                                fontSize: 18
                              ),
                            ),
                            onPressed: () { 
                              //trueを返す
                              Navigator.of(context).pop(true);
                            },
                          ),
                        )
                      ],
                    ),
                )
              ],
            ),
          ),
        );
      }
    );

    //何も入力されなければfalseを返す
    if(result==null){
      return false;
    }
    //何か入力されていれば結果を返す
    return result;
  }


  //csvを選択して中身を返す関数
  //戻り値は配列になる
  Future<List<List<dynamic>>?> importCsv() async {
    //csvデータを選択
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["csv"],
    );

    //何も選ばれなければreturn
    if(result==null){
      return null;
    }

    //選ばれたらパスを取得
    final path = result.files.single.path;

    //パスが空ならreturn
    if(path==null){
      return null;
    }

    final file = File(path);

    final csvString = await file.readAsString();

    //csvデータを文字列に変換
    final rows = const CsvToListConverter().convert(
      csvString,
      eol: "\n"
    );

    return rows;
  }


  //復元時に確認のアラートを出す関数
  Future<bool> confirmRunDialog(String recoveryText) async {
    final result = await showDialog<bool>(context: context,
      builder: (_){
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            height: 270,
            child: Column(
              children: [
                SizedBox(height: 20,),

                Text( //タイトル
                  "確認",
                  style: TextStyle(
                    fontSize: 27,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),

                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 30,
                    vertical: 30
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$recoveryTextデータを復元しますか？",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Texts.subMessageColor,
                          fontSize: 17
                        ),
                      ),
                      Text(
                        "\nこの操作は取り消せません！",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 5
                  ),
                  child: Row( //OK．キャンセルボタン
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.30,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (){
                              showErrorSnackBar(context, "操作が取り消されました");
                              //falseを返す
                              Navigator.of(context).pop(false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ElevatedButtons.cancelButtonBackgroundColor,
                              padding: EdgeInsets.symmetric(horizontal: 2) //余白を小さくする
                            ),
                            child: Text(
                              "キャンセル",
                              style: TextStyle(
                                color: ElevatedButtons.cancelFontColor,
                                fontSize: 15
                              ),
                            )
                          ),
                        ),

                        SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                        
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.30,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ElevatedButtons.backgroundColor
                            ),
                            child: Text(
                              "OK",
                              style: TextStyle(
                                color: ElevatedButtons.fontColor,
                                fontSize: 18
                              ),
                            ),
                            onPressed: () { 
                              //trueを返す
                              Navigator.of(context).pop(true);
                            },
                          ),
                        )
                      ],
                    ),
                )
              ],
            ),
          ),
        );
      }
    );

    //何も入力されなければfalseを返す
    if(result==null){
      return false;
    }
    //何か入力されていれば結果を返す
    return result;
  }

  @override
  Widget build(BuildContext context) {
    //isarを取得
    final Isar isar = ref.read(isarProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded)
        ),
        title: Text("CSVファイルから復元"),
      ),
      body: ListView(
        children: [

          ElevatedButton( //全データ削除ボタン
            onPressed: () async {
              //全データを消去するか確認
              final deleteFlag = await confirmDeleteDialog() ;

              //falseなら何もしない
              if(deleteFlag==false){
                return;
              }

              //trueなら全てのデータを消去する
              if(deleteFlag==true){
                try{
                  isar.writeTxn(() async{
                    isar.animes.clear();
                    isar.genres.clear();
                  });

                  showSnackBar(context, "全てのデータを削除しました");
                }
                catch(e){
                  showErrorSnackBar(
                    context, 
                    "削除に失敗しました．デバッグモードで確認してください．\n${e}"
                  );
                }
                
              }
            },
            child: Text("全データ消去")
          ),


          ElevatedButton( //ジャンル復元ボタン
            onPressed: () async {
              //ファイルを選択し，配列に変換
              final selectedFile = await importCsv();

              //何も選ばれなかったらreturn
              if(selectedFile==null){
                return;
              }

              //ジャンルデータを復元するか確認
              final deleteFlag = await confirmRunDialog("ジャンル") ;

              //falseなら何もしない
              if(deleteFlag==false){
                return;
              }

              //trueならジャンルのデータを復元する
              if(deleteFlag==true){
                try{
                  await isar.writeTxn(() async {

                    for(int i = 1; i < selectedFile.length; i++){

                      final row = selectedFile[i];
                      final genre = Genre();
                      
                      //id
                      genre.id = int.parse(row[0].toString());
                      //ジャンル名
                      genre.name = row[1].toString();
                      //赤
                      genre.redValue = int.parse(row[2].toString());
                      //緑
                      genre.greenValue = int.parse(row[3].toString());
                      //青
                      genre.blueValue = int.parse(row[4].toString());
                      //アイコンの形状
                      genre.iconShape = IconShape.values.byName(
                        row[5].toString().trim(),
                      );

                      await isar.genres.put(genre);
                    }
                  });

                  showSnackBar(context, "ジャンルのデータをインポートしました");
                }
                catch(e){
                  showErrorSnackBar(
                    context, 
                    "復元に失敗しました．デバッグモードで確認してください．\n${e}"
                  );
                }
              }
            },
            child: Text("ジャンルデータ復元")
          ),


          ElevatedButton( //アニメ復元ボタン
            onPressed: () async {
              //ファイルを選択し，配列に変換
              final selectedFile = await importCsv();

              //何も選ばれなかったらreturn
              if(selectedFile==null){
                return;
              }

              //アニメデータを復元するか確認
              final deleteFlag = await confirmRunDialog("アニメ") ;
              
              print("ここまでは上手くいった");

              //falseなら何もしない
              if(deleteFlag==false){
                return;
              }

              //trueならアニメのデータを復元する
              if(deleteFlag==true){
                try{
                  await isar.writeTxn(() async {

                    for(int i = 1; i < selectedFile.length; i++){

                      final row = selectedFile[i];
                      final anime = Anime();

                      //id
                      anime.id = int.parse(row[0].toString());
                      //ステータス
                      anime.status = AnimeStatus.values.byName(
                        row[1].toString().trim()
                      );
                      //タイトル
                      anime.title = row[2].toString();
                      //タイトルかな
                      anime.titleKana = row[3].toString();
                      //日付
                      anime.date = DateTime.parse(row[4].toString());
                      //放送年
                      anime.onAirYear = int.parse(row[5].toString());
                      //放送季節
                      anime.season = OnAirSeason.values.byName(
                        row[6].toString().trim()
                      );
                      //話数
                      anime.epNum = int.parse(row[7].toString());
                      //1話あたりの時間
                      anime.epTime = int.parse(row[8].toString());
                      //評価
                      anime.evaluation = int.parse(row[9].toString());
                      //メモ
                      anime.memo = row[10].toString().trim();

                      await isar.animes.put(anime);
                    }
                  });

                  showSnackBar(context, "アニメのデータをインポートしました");
                }
                catch(e){
                  showErrorSnackBar(
                    context, 
                    "復元に失敗しました．デバッグモードで確認してください．\n${e}"
                  );
                }
              }
            },
            child: Text("アニメデータ復元")
          ),


          ElevatedButton( //リンク復元ボタン
            onPressed: () async {
              //ファイルを選択し，配列に変換
              final selectedFile = await importCsv();

              //何も選ばれなかったらreturn
              if(selectedFile==null){
                return;
              }

              //リンクデータを復元するか確認
              final deleteFlag = await confirmRunDialog("リンク") ;
              
              print("ここまでは上手くいった");

              //falseなら何もしない
              if(deleteFlag==false){
                return;
              }

              //trueならリンクのデータを復元する
              if(deleteFlag==true){
                try{
                  await isar.writeTxn(() async {

                    for(int i = 1; i < selectedFile.length; i++){

                      final row = selectedFile[i];
                      
                      //アニメid
                      final animeId = int.parse(row[0].toString());
                      //ジャンルid
                      final genreId = int.parse(row[1].toString());
                      //アニメ情報を取得
                      final anime = await isar.animes.get(animeId);
                      //ジャンル情報を取得
                      final genre = await isar.genres.get(genreId);

                      if(anime==null || genre==null){
                        continue;
                      }

                      await anime.genres.load();
                      anime.genres.add(genre);
                      await anime.genres.save();
                    }
                  });

                  showSnackBar(context, "リンクのデータをインポートしました");
                }
                catch(e){
                  showErrorSnackBar(
                    context, 
                    "復元に失敗しました．デバッグモードで確認してください．\n${e}"
                  );
                }
              }
            },
            child: Text("リンクデータ復元")
          ),
        ],
      ),
    );
  }
}