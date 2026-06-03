//ジャンルのクラスを定義するコード
import 'package:anime_administration/models/anime.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'genre.g.dart';

@collection
class Genre {
  //ID
  Id id = Isar.autoIncrement;

  //ジャンル名
  //ジャンル名の重複を防ぐためにユニークにする
  //今回はジャンルでフィルターやデータ分析を行うため，@Indexを付ける
  @Index(unique:true)
  late String name;

  //各色のパラメータ
  late int redValue;
  late int greenValue;
  late int blueValue;

  //アイコンの形状
  @enumerated
  late IconShape iconShape;

  //アニメデータへのリンク
  @Backlink(to: "genres")
  final animes=IsarLinks<Anime>();
}

enum IconShape{
  circle,
  square,
  triangle,
  star,
  x,
  plus
}

List<IconData> IconShapeDatas =[
  Icons.fiber_manual_record,
  Icons.stop,
  Icons.play_arrow_sharp,
  Icons.star,
  Icons.close,
  Icons.add
];