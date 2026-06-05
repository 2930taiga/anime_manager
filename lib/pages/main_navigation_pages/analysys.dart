import 'package:anime_administration/models/anime.dart';
import 'package:anime_administration/parts/anime_analysis_parts.dart';
import 'package:anime_administration/providers/isar_provider.dart';
import 'package:flutter/material.dart'; // これがないとWidgetが使えない
//riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';
//isar
import 'package:isar/isar.dart';

//分析ページ
class AnalysisPage extends ConsumerStatefulWidget {
  const AnalysisPage({super.key});

  @override
  ConsumerState<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends ConsumerState<AnalysisPage> {
  //アニメを入れるリスト
  List<Anime> _animes = [];
  //総視聴時間
  int totalTime = 0;

  //アニメをリフレッシュする関数
  Future<void> _refreshAnimes() async{

    final Isar isar = ref.read(isarProvider);

    //代入する用の変数
    int totalTimeTemp =0 ;

    //アニメを一括で取得する
    final allAnimes = await isar.animes.where().findAll();
    //各アニメのジャンルを一括で取得する
    for(final anime in allAnimes){
      await anime.genres.load();
    }

    //総視聴時間を計算する
    totalTimeTemp = _calcurateTotalTIme(allAnimes);

    setState(() {
      //アニメを代入する
      _animes = allAnimes;
      //総視聴時間を代入する
      totalTime = totalTimeTemp;
    });

    print(totalTime);
  }

  //総アニメ視聴時間を計算する関数
  int _calcurateTotalTIme(List<Anime> animes){
    int _totalTime = 0;

    //forループで総視聴時間（分）を計算する
    for(Anime _anime in animes){
      _totalTime += _anime.epNum * _anime.epTime;
    }

    return _totalTime;
  }

  //画面が表示されたら1度だけ画面をリフレッシュする
  @override
  void initState() {
    //親に準備を促す
    super.initState();
    //画面が更新されたらデータを読み込む
    _refreshAnimes();
    //総視聴時間を計算する
    totalTime = _calcurateTotalTIme(_animes);
    print(totalTime);
  }

  @override
  Widget build(BuildContext context) {
    //isarを取得
    final Isar isar = ref.read(isarProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("分析"),
        //backgroundColor: Colors.lightBlue[100],
      ),
      body: _animes.isEmpty
      ? Center(
        child: Text(
          "データが登録されていません",
          style: TextStyle(
            color: Colors.grey
          ),
        ),
      )
      :Expanded(
        child: Scrollbar(
          child: ListView(
            children: [

              //時間に関する情報
              AnimeAnalysisTime(anime: _animes, totalTime: totalTime)

            ],
          )
        )
      ),
    );
  }
}