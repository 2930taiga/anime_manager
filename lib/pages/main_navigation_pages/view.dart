import 'package:anime_administration/models/anime.dart';
//import 'package:anime_administration/models/genre.dart';
import 'package:anime_administration/parameter_settings.dart';
import 'package:anime_administration/parts/anime_info_parts.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
//登録ページ
import 'registar_navigation.dart';
//isarのprovider
import 'package:anime_administration/providers/isar_provider.dart';
//riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';
//アニメ情報ページ
import 'package:anime_administration/pages/main_navigation_pages/view/anime_info.dart';

class ViewPage extends ConsumerStatefulWidget {
  const ViewPage({super.key,});

  @override
  ConsumerState<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends ConsumerState<ViewPage> {
  //アニメのリストを保持する変数
  List<Anime> _animes=[];
  //ジャンルのリストを保持する変数
  //List<Genre> _genres=[];

  //ステータスの日本語
  List<String> statusJp =[
    "未視聴",
    "視聴中",
    "視聴済み",
    "視聴中止",
    "中断"
  ];

  //季節の日本語
  List<String> seasonJP = [
    "春",
    "夏",
    "秋",
    "冬"
  ];

  //アニメ一覧を取得する関数
  Future<void> _refreshAnimes() async {
    //アニメを一覧で表示する
    final isar = ref.read(isarProvider);
    final allAnimes = await isar.animes.where().findAll();
    //各アニメのジャンルを一括で取得する
    for(final anime in allAnimes){
      await anime.genres.load();
    }

    setState(() {
      _animes = allAnimes;
    });
  }

  //画面が表示されたら一度だけ画面をリフレッシュする
  void initState(){
    //親に準備を促す
    super.initState();
    //画面が更新されたらデータを読み込む
    _refreshAnimes();
  }

  //削除するときに，本当に消していいか確認するアラートを表示する関数を定義
  void deleteConfigAlert(int deleteAnimeIndex){
    showDialog(context: context,
      builder: (_){
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            height: 205,
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

                SizedBox(height: 20,),

                Text( //サブメッセージ
                  "「${_animes[deleteAnimeIndex].title}」を削除しますか？",
                  style: TextStyle(
                    color: Texts.subMessageColor,
                    fontSize: 17
                  ),
                ),

                SizedBox(height: 30,),

                Row( //OK．キャンセルボタン
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.30,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
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
                        onPressed: () async {
                          Navigator.pop(context);
                          await deleteAnime(deleteAnimeIndex); //データを消す関数を呼ぶ（時間がかかる処理なので，awaitを付ける）
                          _refreshAnimes(); //画面をリフレッシュする
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ElevatedButtons.backgroundColor
                        ),
                        child: Text(
                          "OK",
                          style: TextStyle(
                            color: ElevatedButtons.fontColor,
                            fontSize: 18
                          ),
                        )
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  //アニメを削除する関数
  Future<void> deleteAnime(int deleteIndex) async{
    //削除するアニメのタイトル
    String deleteTitle = _animes[deleteIndex].title;
    //削除するアニメのid
    int deleteId = _animes[deleteIndex].id;
    //isarを取得
    Isar isar = ref.read(isarProvider);

    //削除する
    await isar.writeTxn(() async{
      try{
        //削除
        await isar.animes.delete(deleteId);

        //スナックバーにメッセージを表示
        showSnackBar(context, "「$deleteTitle」を削除しました");

        //画面をリフレッシュ
        _refreshAnimes();
      }
      catch(e){
        showSnackBar(context, "削除に失敗しました．デバッグモードで確認してください");
      }
    });
  }

  @override
  Widget build(BuildContext content){
    //providerのインスタンスを作成
    final isar = ref.read(isarProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("一覧"),
        backgroundColor: Colors.lightBlue[100],
        actions: [
          IconButton( //ソートボタン
            onPressed: (){
            },
            icon: Icon(Icons.sort)
          ),
          IconButton( //フィルターボタン
            onPressed: (){},
            icon: Icon(Icons.filter_alt)
          )
        ],
      ),
      body: _animes.isEmpty
      ? Center(
        child: Text(
          "データが登録されていません",
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey
          ),
        ),
      )
      : Column(
          children: [
            SizedBox(height: 20,),

            Expanded(
              child:  Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  itemCount: _animes.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: () async {
                        //アニメ情報ページに遷移
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnimeInfo(
                              anime: _animes[index],
                            )
                          )
                        );

                        //戻ってきたら画面を更新
                        _refreshAnimes();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5
                        ),
                        child: Container( //カード
                        padding: EdgeInsetsDirectional.symmetric(
                          vertical: 3,
                          horizontal: 3
                        ),
                          decoration: BoxDecoration(
                            color: StatusColors.boxColors[_animes[index].status.index].withValues(alpha: 0.25),
                            border: Border.all(
                              color: StatusColors.boxColors[_animes[index].status.index],
                            ),
                            borderRadius: BorderRadiusDirectional.circular(20)
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //タイトル
                                      AnimeInfoTitle(anime: _animes[index],onLine: true,),
                                      
                                      //ジャンル
                                      AnimeInfoSimpleGenre(anime: _animes[index]),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //簡易版info
                                          AnimeInfoSimpleInfo(anime: _animes[index]),

                                          //評価
                                          AnimeInfoEvaluation(anime: _animes[index]),

                                          if(_animes[index].memo != "") //メモ欄（空白なら表示しない）
                                          AnimeInfoSimpleMemo(anime: _animes[index])
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ),
                              
                              Column(
                                children: [
                                  PopupMenuButton(
                                    color: Color.fromARGB(255, 255, 255, 255).withValues(alpha: 0),
                                    elevation: 1,
                                    shadowColor: Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0.5),
                                    padding: EdgeInsetsGeometry.zero,
                                    onSelected: (value) async {
                                      //選ばれたステータスにデータを更新し，画面をリフレッシュ
                                      //話数を増やす
                                      try{
                                        await isar.writeTxn(() async {
                                          //現在の情報をコピー
                                          final newAnime = _animes[index];
                                          // ステータスを更新
                                          newAnime.status = AnimeStatus.values[value];
                                          //データベースに保存する
                                          await isar.animes.put(newAnime);
                                          //スナックバーにメッセージを表示
                                          showSnackBar(
                                            context,
                                            "${_animes[index].title}のステータスを更新しました"
                                          );
                                        });
                                        //画面を更新
                                        _refreshAnimes();
                                      }
                                      catch(e){
                                        //失敗したメッセージを表示
                                        showSnackBar(
                                          context,
                                          "ステータスの更新に失敗しました．デバッグモードで確認してください"
                                        );
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        padding: EdgeInsets.zero,
                                        value: 0,
                                        child: StatusMenuItem(
                                          backgroundColor: StatusColors.boxColors[0],
                                          textColor: StatusColors.textColors[0],
                                          text: "未視聴",
                                          icon: Icons.circle_outlined
                                        )
                                      ),
                                      PopupMenuItem(
                                        padding: EdgeInsets.zero,
                                        value: 1,
                                        child: StatusMenuItem(
                                          backgroundColor: StatusColors.boxColors[1],
                                          textColor: StatusColors.textColors[1],
                                          text: "視聴中",
                                          icon: Icons.circle
                                        )
                                      ),
                                      PopupMenuItem(
                                        padding: EdgeInsets.zero,
                                        value: 2,
                                        child: StatusMenuItem(
                                          backgroundColor: StatusColors.boxColors[2],
                                          textColor: StatusColors.textColors[2],
                                          text: "視聴済み",
                                          icon: Icons.check
                                        )
                                      ),
                                      PopupMenuItem(
                                        padding: EdgeInsets.zero,
                                        value: 3,
                                        child: StatusMenuItem(
                                          backgroundColor: StatusColors.boxColors[3],
                                          textColor: StatusColors.textColors[3],
                                          text: "視聴中止",
                                          icon: Icons.close
                                        )
                                      ),
                                      PopupMenuItem(
                                        padding: EdgeInsets.zero,
                                        value: 4,
                                        child: StatusMenuItem(
                                          backgroundColor: StatusColors.boxColors[4],
                                          textColor: StatusColors.textColors[4],
                                          text: "視聴中断",
                                          icon: Icons.stop
                                        )
                                      ),
                                    ],
                                    child: Container( //ステータス
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5
                                      ),
                                      decoration: BoxDecoration(
                                        color: StatusColors.boxColors[_animes[index].status.index],
                                        borderRadius: BorderRadiusDirectional.circular(20)
                                      ),
                                      child: Text(
                                        statusJp[_animes[index].status.index],
                                        style: TextStyle(
                                          color: StatusColors.textColors[_animes[index].status.index],
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  

                                  //視聴中なら話数変更ボタン
                                  if(_animes[index].status==AnimeStatus.watching)
                                  Padding(
                                    padding: EdgeInsetsGeometry.symmetric(
                                      vertical: 3
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            //話数を増やす
                                            try{
                                              await isar.writeTxn(() async {
                                                //現在の情報をコピー
                                                final newAnime = _animes[index];
                                                //話数だけ増やす
                                                newAnime.epNum = _animes[index].epNum+1;
                                                //データベースに保存する
                                                await isar.animes.put(newAnime);
                                                //スナックバーにメッセージを表示
                                                showSnackBar(
                                                  context,
                                                  "${_animes[index].title}の話数を増やしました"
                                                );
                                              });
                                              //画面を更新
                                              _refreshAnimes();
                                            }
                                            catch(e){
                                              //失敗したメッセージを表示
                                              showSnackBar(
                                                context,
                                                "話数の更新に失敗しました．デバッグモードで確認してください"
                                              );
                                            }
                                          },
                                          icon: Icon(Icons.add)
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            //話数を減らす
                                            try{
                                              await isar.writeTxn(() async {
                                                //現在の情報をコピー
                                                final newAnime = _animes[index];
                                                //話数だけ増やす
                                                newAnime.epNum = _animes[index].epNum-1;
                                                //データベースに保存する
                                                await isar.animes.put(newAnime);
                                                //スナックバーにメッセージを表示
                                                showSnackBar(
                                                  context,
                                                  "${_animes[index].title}の話数を減らしました"
                                                );
                                              });
                                              //画面を更新
                                              _refreshAnimes();
                                            }
                                            catch(e){
                                              //失敗したメッセージを表示
                                              showSnackBar(
                                                context,
                                                "話数の更新に失敗しました．デバッグモードで確認してください"
                                              );
                                            }
                                          },
                                          icon: Icon(Icons.remove)
                                        )
                                      ],
                                    ),
                                  ),

                                  //視聴中でなければミートボールアイコン
                                  if(_animes[index].status!=AnimeStatus.watching)
                                  PopupMenuButton(
                                    padding: EdgeInsets.zero,
                                    onSelected: (value){
                                      if(value==0){ //編集画面へ

                                      }
                                      if(value==1){ //削除する
                                        deleteConfigAlert(index);
                                      }
                                    },
                                    itemBuilder: (context) =>[
                                      PopupMenuItem(
                                        value: 0,
                                        child: MoreMenuItem(
                                          icon: Icons.edit,
                                          text: "編集",
                                          textColor: StatusColors.textColors[0] //未視聴の色がちょうどよさそう
                                        )
                                      ),
                                      PopupMenuItem(
                                        value: 1,
                                        child: MoreMenuItem(
                                          icon: Icons.delete,
                                          text: "削除",
                                          textColor: Colors.red
                                        )
                                      )
                                    ],
                                    child: Padding(
                                      padding: EdgeInsetsGeometry.symmetric(
                                        vertical: 8
                                      ),
                                      child: Icon(
                                        Icons.more_horiz,
                                        size: 27,
                                      )
                                    )
                                  ),
                                ],
                              ),
                            ],
                          )
                        ),
                      ),
                    );
                  }
                ),
              )
            )
          ],
        ),
      floatingActionButton: FloatingActionButton(
        //onPressed: goToRegistarPage,
        onPressed: () async {
          //登録画面に遷移
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context)=> RegistarNavigation(),
              fullscreenDialog: true
            )
          );

          //戻ってきたら画面を更新
          _refreshAnimes();

        },
        child: Icon(Icons.add),
      ),
    ); 
  }
}

//ステータスメニューの項目を定義
class StatusMenuItem extends StatelessWidget {
  //色
  final Color backgroundColor;
  final Color textColor;
  //テキスト
  final String text;
  final IconData icon;
  const StatusMenuItem({super.key,required this.backgroundColor,required this.textColor ,required this.text,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsetsGeometry.symmetric(
        vertical: 0
      ),
      child: Container(
        //width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 11,
          //horizontal: 10
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadiusDirectional.circular(6)
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 0
              ),
              child: Icon(
                icon,
                size: 16,
                color: textColor,
              ),
            ),
            Padding(
              padding:EdgeInsetsGeometry.symmetric(
                horizontal: 3
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}

class MoreMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor; 
  const MoreMenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 4
            ),
            child: Icon(
              icon,
              size: 16,
              color: textColor,
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 3
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }
}