import 'package:anime_administration/models/anime.dart';
import 'package:anime_administration/models/genre.dart';
import 'package:anime_administration/parameter_settings.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
//登録ページ
import 'registar_navigation.dart';
//isarのprovider
import 'package:anime_administration/providers/isar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewPage extends ConsumerStatefulWidget {
  const ViewPage({super.key,});

  @override
  ConsumerState<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends ConsumerState<ViewPage> {
  //アニメのリストを保持する変数
  List<Anime> _animes=[];
  //ジャンルのリストを保持する変数
  List<Genre> _genres=[];

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

  //登録ページに遷移する関数
  void goToRegistarPage(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context)=> RegistarNavigation(),
        fullscreenDialog: true
      )
    );
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
                      onTap: (){
                        print("たっぷされた${_animes[index].title}");
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
                                      Container( //タイトル
                                        padding: EdgeInsets.symmetric(
                                          vertical: 1,
                                        ),
                                        child: Text(
                                          _animes[index].title,
                                          overflow: TextOverflow.ellipsis, //長すぎるときは...で終わらせる
                                          maxLines: 1, //最大1行
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 1
                                          ),
                                          child: Wrap( //ジャンル表示欄
                                          spacing: 5,
                                          runSpacing: 3,
                                          children: _animes[index].genres.map((genre) {
                                            return Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 5,
                                                vertical: 1
                                              ),
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                  255,
                                                  genre.redValue,
                                                  genre.greenValue,
                                                  genre.blueValue
                                                ).withValues(alpha: 0.2),
                                                borderRadius: BorderRadius.circular(8)
                                              ),
                                              child: Text(
                                                genre.name,
                                                style: TextStyle(
                                                  fontSize: 10.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                    255,
                                                    genre.redValue,
                                                    genre.greenValue,
                                                    genre.blueValue
                                                  )
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container( //アニメの情報出すところ
                                            padding: EdgeInsets.symmetric(
                                              vertical: 1
                                            ),
                                            child: Text(
                                              "${_animes[index].onAirYear} "
                                              "${seasonJP[_animes[index].season.index]}"
                                              "アニメ｜"
                                              "${_animes[index].epNum}"
                                              "話｜"
                                              "${_animes[index].epTime}"
                                              "分 / 話",
                                              style: TextStyle(
                                                fontSize: 13.5
                                              ),
                                            ),
                                          ),

                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 1
                                            ),
                                            child: Row( //評価アイコン
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 17,
                                                  color: _animes[index].evaluation>=1
                                                  ? Color.fromARGB(255, 255, 192, 0)
                                                  : Colors.grey,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 17,
                                                  color: _animes[index].evaluation>=2
                                                  ? Color.fromARGB(255, 255, 192, 0)
                                                  : Colors.grey,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 17,
                                                  color: _animes[index].evaluation>=3
                                                  ? Color.fromARGB(255, 255, 192, 0)
                                                  : Colors.grey,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 17,
                                                  color: _animes[index].evaluation>=4
                                                  ? Color.fromARGB(255, 255, 192, 0)
                                                  : Colors.grey,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 17,
                                                  color: _animes[index].evaluation>=5
                                                  ? Color.fromARGB(255, 255, 192, 0)
                                                  : Colors.grey,
                                                ),

                                                Text( //評価テキスト
                                                  " ${_animes[index].evaluation.toString()}.0 / 5.0",
                                                  style: TextStyle(
                                                    fontSize: 14
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          if(_animes[index].memo != "") //メモ欄（空白なら表示しない）
                                          Text(
                                            "メモ：${_animes[index].memo}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ),
                              
                              Column(
                                children: [
                                  PopupMenuButton(
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

                                  //視聴中でなければハンバーガーアイコン
                                  if(_animes[index].status!=AnimeStatus.watching)
                                  Padding(
                                    padding: EdgeInsetsGeometry.symmetric(
                                      vertical: 1
                                    ),
                                    child: IconButton(
                                      onPressed: (){},
                                      icon: Icon(Icons.more_horiz)
                                    )
                                  )
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
          vertical: 13,
          //horizontal: 10
        ),
        decoration: BoxDecoration(
          color: backgroundColor
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
