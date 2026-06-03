import 'package:anime_administration/models/anime.dart';
import 'package:anime_administration/models/genre.dart';
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
                            color: _animes[index].status==AnimeStatus.never //未視聴
                            ? Color.fromARGB(255, 245, 245, 245).withValues(alpha: 0.25)
                            : _animes[index].status==AnimeStatus.watching //視聴中
                            ? Color.fromARGB(255, 232, 245, 233).withValues(alpha: 0.25)
                            : _animes[index].status == AnimeStatus.complete //視聴済み
                            ? Color.fromARGB(255, 227, 242, 253).withValues(alpha: 0.25)
                            : _animes[index].status==AnimeStatus.cancel //視聴中止
                            ? Color.fromARGB(255, 255, 235, 238).withValues(alpha: 0.25)
                            : Color.fromARGB(255, 255, 248, 225).withValues(alpha: 0.25), //視聴中断
                            border: Border.all(
                              color: _animes[index].status==AnimeStatus.never //未視聴
                              ? Color.fromARGB(255, 245, 245, 245)
                              : _animes[index].status==AnimeStatus.watching //視聴中
                              ? Color.fromARGB(255, 232, 245, 233)
                              : _animes[index].status == AnimeStatus.complete //視聴済み
                              ? Color.fromARGB(255, 227, 242, 253)
                              : _animes[index].status==AnimeStatus.cancel //視聴中止
                              ? Color.fromARGB(255, 255, 235, 238)
                              : Color.fromARGB(255, 255, 248, 225), //視聴中断
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
                                )
                              ),
                              
                              Column(
                                children: [
                                  Container( //ステータス
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5
                                    ),
                                    decoration: BoxDecoration(
                                      color: _animes[index].status==AnimeStatus.never //未視聴
                                      ? Color.fromARGB(255, 245, 245, 245)
                                      : _animes[index].status==AnimeStatus.watching //視聴中
                                      ? Color.fromARGB(255, 232, 245, 233)
                                      : _animes[index].status == AnimeStatus.complete //視聴済み
                                      ? Color.fromARGB(255, 227, 242, 253)
                                      : _animes[index].status==AnimeStatus.cancel //視聴中止
                                      ? Color.fromARGB(255, 255, 235, 238)
                                      : Color.fromARGB(255, 255, 248, 225), //視聴中断
                                      borderRadius: BorderRadiusDirectional.circular(20)
                                    ),
                                    child: Text(
                                      statusJp[_animes[index].status.index],
                                      style: TextStyle(
                                        color: _animes[index].status==AnimeStatus.never //未視聴
                                        ? Color.fromARGB(255, 97, 97, 97)
                                        : _animes[index].status==AnimeStatus.watching //視聴中
                                        ? Color.fromARGB(255, 46, 125, 50)
                                        : _animes[index].status == AnimeStatus.complete //視聴済み
                                        ? Color.fromARGB(255, 21, 101, 192)
                                        : _animes[index].status==AnimeStatus.cancel //視聴中止
                                        ? Color.fromARGB(255, 198, 40, 40)
                                        : Color.fromARGB(255, 183, 129, 3), //視聴中断

                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: (){
                                      _refreshAnimes();
                                    },
                                    icon: Icon(Icons.more_horiz)
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
        onPressed: goToRegistarPage,
        child: Icon(Icons.add),
      ),
    ); 
  }
}