import 'package:anime_administration/models/anime.dart';
import 'package:anime_administration/models/genre.dart';
import 'package:anime_administration/parameter_settings.dart';
import 'package:anime_administration/parts/setting_parts.dart';
import 'package:anime_administration/providers/isar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

//データ消去に関するページ
class DeleteNavigationPage extends ConsumerWidget {
  final BuildContext context;
  const DeleteNavigationPage({
    super.key,
    required this.context
  });

  //削除のダイアログを表示する関数
  void confirmDeleteDialog(int deleteOption, Isar isar){
    showDialog(context: context,
      builder: (_){
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            height: 300,
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
                      if(deleteOption==0)
                      Text(
                        "アニメに関するデータを",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Texts.subMessageColor,
                          fontSize: 17
                        ),
                      ),
                      if(deleteOption==1)
                      Text(
                        "ジャンルに関するデータを",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Texts.subMessageColor,
                          fontSize: 17
                        ),
                      ),
                      Text(
                        "全て削除しますか？",
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
                              Navigator.pop(context);
                              showErrorSnackBar(context, "操作が取り消されました");
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
                            onPressed: () async { //データを消去する
                              try{
                                await isar.writeTxn(() async{
                                  //アニメのデータを削除
                                  if(deleteOption==0){
                                    await isar.animes.clear();
                                  }
                                  //ジャンルのデータを消去する
                                  if(deleteOption==1){
                                    await isar.genres.clear();
                                  }
                                });

                                showSnackBar(context, "データを消去しました");
                              }
                              catch(e){
                                showErrorSnackBar(
                                  context,
                                  "データ消去に失敗しました．デバッグモードで確認してください．\n{$e}"
                                );
                              }

                              Navigator.pop(context);
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
  } 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        title: Text("データ消去"),
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
                confirmDeleteDialog(0,isar);
              },
              child: SettingNonNavigationCard(
                icon: Icons.delete_forever_outlined,
                iconColor: Colors.red,
                titleText: "アニメデータ",
                titleTextColor: Colors.red,
                subText: "アニメのデータを全て消去する"
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
                confirmDeleteDialog(1,isar);
              },
              child: SettingNonNavigationCard(
                icon: Icons.delete_forever_outlined,
                iconColor: Colors.red,
                titleText: "ジャンルデータ",
                titleTextColor: Colors.red,
                subText: "ジャンルのデータを全て消去する"
              ),
            ),
          ),
        ],
      ),
    );
  }
}