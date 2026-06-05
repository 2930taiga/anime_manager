import 'package:anime_administration/models/anime.dart';
import 'package:anime_administration/parameter_settings.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

//アニメ情報を表示する画面
class AnimeInfo extends StatefulWidget {
  final Anime anime;
  const AnimeInfo({
    super.key,
    required this.anime
  });

  @override
  State<AnimeInfo> createState() => _AnimeInfoState();
}

class _AnimeInfoState extends State<AnimeInfo> {
  //paddingのパラメータ
  double cardPaddingHorizontal = 5;
  double cardPaddingVertical = 5;
  double containerPaddingHorizontal = 5;
  double containerPaddingVertical = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.anime.title),
      ),
      body: Column(
        children: [
          Padding( //タイトルその他
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: cardPaddingHorizontal,
              vertical: cardPaddingVertical
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: containerPaddingHorizontal,
                vertical: containerPaddingVertical
              ),
              child: Column(
                children: [
                  Text(
                    "data",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  )
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
              padding: EdgeInsets.symmetric(
                horizontal: containerPaddingHorizontal,
                vertical: containerPaddingVertical
              ),
              child: Text("ここにジャンル"),
            ),
          ),
        ],
      ),
    );
  }
}