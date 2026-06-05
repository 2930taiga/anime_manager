import 'package:anime_administration/models/anime.dart';
import 'package:flutter/material.dart';

//アニメinfoのパーツを置いておくスクリプト

//タイトル
class AnimeInfoTitle extends StatelessWidget {
  final Anime anime;
  //折り返すかどうか
  final bool onLine;
  const AnimeInfoTitle({super.key,required this.anime, required this.onLine});

  @override
  Widget build(BuildContext context) {
    return Text( //タイトル
      anime.title,
      maxLines: onLine //行数指定
      ? 1
      : null,
      overflow: onLine
      ? TextOverflow.ellipsis
      : null,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
    );
  }
}

//タイトルかな
class AnimeInfoTitleKana extends StatelessWidget {
  final Anime anime;
  const AnimeInfoTitleKana({super.key,required this.anime});

  @override
  Widget build(BuildContext context) {
    return Text(
      anime.titleKana,
      style: TextStyle(
        fontSize: 17
      ),
    );
  }
}

//ジャンル
class AnimeInfoGenre extends StatelessWidget {
  final Anime anime;
  const AnimeInfoGenre({super.key,required this.anime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 1
        ),
        child: Wrap(
        spacing: 5,
        runSpacing: 3,
        children: anime.genres.map((genre) {
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
    );
  }
}

//アニメ情報欄（簡易ver）
class AnimeInfoSimpleInfo extends StatelessWidget {
  final Anime anime;
  const AnimeInfoSimpleInfo({super.key,required this.anime});

  //季節の日本語
  static List<String> seasonJP = [
    "春",
    "夏",
    "秋",
    "冬"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 1
          ),
          child: Text(
            "${anime.onAirYear} "
            "${seasonJP[anime.season.index]}"
            "アニメ｜"
            "${anime.date.year}"
            "/"
            "${anime.date.month}"
            "/"
            "${anime.date.day}",
            style: TextStyle(
              fontSize: 13.5
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 1
          ),
          child: Text(
            "${anime.epNum}"
            "話｜"
            "${anime.epTime}"
            "分 / 話",
            style: TextStyle(
              fontSize: 13.5
            ),
          ),
        ),
      ],
    );
  }
}

//評価欄（簡易ver）
class AnimeInfoEvaluation extends StatelessWidget {
  final Anime anime;
  const AnimeInfoEvaluation({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 1
      ),
      child: Row( //評価アイコン
        children: [
          Icon(
            Icons.star,
            size: 17,
            color: anime.evaluation>=1
            ? Color.fromARGB(255, 255, 192, 0)
            : Colors.grey,
          ),
          Icon(
            Icons.star,
            size: 17,
            color: anime.evaluation>=2
            ? Color.fromARGB(255, 255, 192, 0)
            : Colors.grey,
          ),
          Icon(
            Icons.star,
            size: 17,
            color: anime.evaluation>=3
            ? Color.fromARGB(255, 255, 192, 0)
            : Colors.grey,
          ),
          Icon(
            Icons.star,
            size: 17,
            color: anime.evaluation>=4
            ? Color.fromARGB(255, 255, 192, 0)
            : Colors.grey,
          ),
          Icon(
            Icons.star,
            size: 17,
            color: anime.evaluation>=5
            ? Color.fromARGB(255, 255, 192, 0)
            : Colors.grey,
          ),
          Text( //評価テキスト
            " ${anime.evaluation.toString()}.0 / 5.0",
            style: TextStyle(
              fontSize: 14
            ),
          ),
        ],
      ),
    );
  }
}

//メモ欄（簡易ver）
class AnimeInfoMemo extends StatelessWidget {
  final Anime anime;
  const AnimeInfoMemo({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Text(
      "メモ：${anime.memo}",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey
      ),
    );
  }
}

//詳細アニメ情報


//話数更新ボタン

