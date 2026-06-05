import 'package:anime_administration/models/anime.dart';
import 'package:anime_administration/parameter_settings.dart';
import 'package:anime_administration/parts/anime_info_parts.dart';
import 'package:anime_administration/providers/isar_provider.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//ステータスのItemをここでも使うために入れる
import 'package:anime_administration/pages/main_navigation_pages/view.dart';

//アニメ情報を表示する画面
class AnimeInfo extends ConsumerStatefulWidget {
  final Anime anime;
  const AnimeInfo({
    super.key,
    required this.anime
  });

  @override
  ConsumerState<AnimeInfo> createState() => _AnimeInfoState();
}

class _AnimeInfoState extends ConsumerState<AnimeInfo> {
  //paddingのパラメータ
  double cardPaddingHorizontal = 10;
  double cardPaddingVertical = 5;
  double containerPaddingHorizontal = 8;
  double containerPaddingVertical = 8;

  //タイトル（かな）を表示するかどうか
  bool showTitleKana = false;
  //詳細情報を表示するかどうか
  bool detailInfo = true;
  //ジャンルの詳細を表示するかどうか
  bool showGenreInfo = true;
  //時間の詳細を表示するかどうか
  bool showTimeInfo = true;

  //ステータスの日本語
  List<String> statusJp =[
    "未視聴",
    "視聴中",
    "視聴済み",
    "視聴中止",
    "中断"
  ];

  @override
  Widget build(BuildContext context) {
    //データベースを取得
    final Isar isar = ref.read(isarProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: StatusColors.boxColors[widget.anime.status.index],

        leading: IconButton( //戻るボタン
          onPressed:(){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back)
        ),

        title: Text(widget.anime.title), //タイトル

        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.more_vert_outlined)
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              child: ListView(
                children: [

                  SizedBox(height: 20,),

                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: cardPaddingHorizontal,
                      vertical: cardPaddingVertical
                    ),
                    child: Container( //タイトルその他のカード
                      width: double.infinity,
                      //height: 500,
                      padding: EdgeInsets.symmetric(
                        horizontal: containerPaddingHorizontal,
                        vertical: containerPaddingVertical
                      ),
                      decoration: BoxDecoration(
                        color: StatusColors.boxColors[widget.anime.status.index].withValues(alpha: 0.4),
                        border: Border.all(
                          color: StatusColors.boxColors[widget.anime.status.index],),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //タイトル表示欄
                                    GestureDetector(
                                      child: AnimeInfoTitle(anime: widget.anime,onLine: false,),
                                      //タップするとタイトルかなを表示する
                                      onTap: (){
                                        setState(() {
                                          if(showTitleKana==true){showTitleKana=false;}
                                          else{showTitleKana=true;}
                                        });
                                      },
                                    ),
                                    

                                    if(showTitleKana==true) //タイトルかな表示欄
                                    AnimeInfoTitleKana(anime: widget.anime),

                                    //info欄（簡易ver）
                                    //if(detailInfo==false)
                                    AnimeInfoSimpleInfo(anime: widget.anime),
                                    
                                    //評価欄（簡易ver）
                                    //if(detailInfo==false)
                                    AnimeInfoEvaluation(anime: widget.anime),

                                    //メモ欄（簡易ver）
                                    if(widget.anime.memo!="")
                                    AnimeInfoSimpleMemo(anime: widget.anime)
                                  ],
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
                                          final newAnime = widget.anime;
                                          // ステータスを更新
                                          newAnime.status = AnimeStatus.values[value];
                                          //データベースに保存する
                                          await isar.animes.put(newAnime);
                                          //スナックバーにメッセージを表示
                                          showSnackBar(
                                            context,
                                            "${widget.anime.title}のステータスを更新しました"
                                          );
                                          //カードの色を変えるために実行する
                                          setState(() {});
                                        });
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
                                        color: StatusColors.boxColors[widget.anime.status.index],
                                        borderRadius: BorderRadiusDirectional.circular(20)
                                      ),
                                      child: Text(
                                        statusJp[widget.anime.status.index],
                                        style: TextStyle(
                                          color: StatusColors.textColors[widget.anime.status.index],
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),

                                  //視聴中なら話数変更ボタンを表示
                                  if(widget.anime.status==AnimeStatus.watching)
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          //話数を増やす
                                          try{
                                            await isar.writeTxn(() async {
                                              //現在の情報をコピー
                                              final newAnime = widget.anime;
                                              //話数だけ増やす
                                              newAnime.epNum = widget.anime.epNum+1;
                                              //データベースに保存する
                                              await isar.animes.put(newAnime);
                                              //スナックバーにメッセージを表示
                                              showSnackBar(
                                                context,
                                                "${widget.anime.title}の話数を増やしました"
                                              );
                                            });

                                            setState(() {});
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
                                              final newAnime = widget.anime;
                                              //話数だけ増やす
                                              newAnime.epNum = widget.anime.epNum-1;
                                              //データベースに保存する
                                              await isar.animes.put(newAnime);
                                              //スナックバーにメッセージを表示
                                              showSnackBar(
                                                context,
                                                "${widget.anime.title}の話数を減らしました"
                                              );
                                            });
                                            //画面を更新
                                            setState(() {});
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

                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding( //基本情報
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: cardPaddingHorizontal,
                      vertical: cardPaddingVertical
                    ),
                    child: Container(
                      width: double.infinity,
                      //height: 500,
                      padding: EdgeInsets.symmetric(
                        horizontal: containerPaddingHorizontal,
                        vertical: containerPaddingVertical
                      ),
                      decoration: BoxDecoration(
                        color: StatusColors.boxColors[widget.anime.status.index].withValues(alpha: 0.5),
                        border: Border.all(
                          color: StatusColors.boxColors[widget.anime.status.index],),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: 5,
                              left: 5,
                              bottom: 13,
                              top: 8
                            ),
                            child:GestureDetector(
                              onTap: (){
                                setState(() {
                                  if(detailInfo==true){detailInfo=false;}
                                  else{detailInfo=true;}
                                });
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text( //「基本情報」
                                      "基本情報",
                                      style: TextStyle(
                                        color: StatusColors.textColors[widget.anime.status.index],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    detailInfo
                                    ? Icons.expand_less
                                    : Icons.expand_more
                                  )
                                ],
                              ),
                            )
                          ),

                          //詳細情報欄
                          if(detailInfo==true)
                          AnimeInfoDetailInfo(anime: widget.anime)
                        ],
                      ),
                    ),
                  ),

                  Padding( //ジャンル
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: cardPaddingHorizontal,
                      vertical: cardPaddingVertical
                    ),
                    child: Container(
                      width: double.infinity,
                      //height: 500,
                      padding: EdgeInsets.symmetric(
                        horizontal: containerPaddingHorizontal,
                        vertical: containerPaddingVertical
                      ),
                      decoration: BoxDecoration(
                        color: StatusColors.boxColors[widget.anime.status.index].withValues(alpha: 0.4),
                        border: Border.all(
                          color: StatusColors.boxColors[widget.anime.status.index],),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: 5,
                              left: 5,
                              bottom: 13,
                              top: 8
                            ),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  if(showGenreInfo==true){showGenreInfo=false;}
                                  else{showGenreInfo=true;}
                                });
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text( //「基本情報」
                                      "ジャンル",
                                      style: TextStyle(
                                        color: StatusColors.textColors[widget.anime.status.index],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    showGenreInfo
                                    ? Icons.expand_less
                                    : Icons.expand_more
                                  )
                                ],
                              ),
                            )
                          ),

                          //詳細情報欄
                          if(showGenreInfo==true)
                          AnimeInfoGenres(anime: widget.anime)
                        ],
                      ),
                    ),
                  ),

                  Padding( //アニメを見た時間
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: cardPaddingHorizontal,
                      vertical: cardPaddingVertical
                    ),
                    child: Container(
                      width: double.infinity,
                      //height: 500,
                      padding: EdgeInsets.symmetric(
                        horizontal: containerPaddingHorizontal,
                        vertical: containerPaddingVertical
                      ),
                      decoration: BoxDecoration(
                        color: StatusColors.boxColors[widget.anime.status.index].withValues(alpha: 1),
                        border: Border.all(
                          color: StatusColors.boxColors[widget.anime.status.index],),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: 5,
                              left: 5,
                              bottom: 13,
                              top: 8
                            ),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  if(showTimeInfo==true){showTimeInfo=false;}
                                  else{showTimeInfo=true;}
                                });
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text( //「基本情報」
                                      "このアニメを見た時間",
                                      style: TextStyle(
                                        color: StatusColors.textColors[widget.anime.status.index],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    showTimeInfo
                                    ? Icons.expand_less
                                    : Icons.expand_more
                                  )
                                ],
                              ),
                            )
                          ),

                          //分析画面欄
                          if(showTimeInfo==true)
                          AnimeInfoAnalysis(anime: widget.anime),
                        ],
                      ),
                    ),
                  ),

                  //一番したまでスクロールできるようにするためのbox
                    const SizedBox(height: 60,)
                ],
              )
            )
          ),
        ],
      ),
    );
  }
}