import 'package:anime_administration/models/anime.dart';
import 'package:anime_administration/models/genre.dart';
import 'package:anime_administration/parameter_settings.dart';
import 'package:anime_administration/parts/setting_parts.dart';
import 'package:anime_administration/providers/isar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

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
  Future<bool> confirmDeleteDialog(Isar isar) async {
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
          ElevatedButton(
            onPressed: () async {
              //全データを消去するか確認
              final deleteFlag = await confirmDeleteDialog(isar) ;

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
          )
        ],
      ),
    );
  }
}