//データベースを扱うために入れる
import 'package:isar/isar.dart';

//ジャンルモデルをインポート
import 'genre.dart';

//作成されるモデルファイル名
part 'anime.g.dart';

@collection
class Anime {
  //Isar専用のID（自動インクリメント）
  Id id = Isar.autoIncrement;

  //ステータス
  @Index(type: IndexType.value)
  @enumerated
  late AnimeStatus status;

  //タイトル
  @Index(type: IndexType.value)
  late String title;

  //タイトルかな
  @Index(type: IndexType.value)
  late String titleKana;

  //日付
  @Index(type: IndexType.value)
  DateTime date=DateTime.now();

  //放送年
  @Index(type: IndexType.value)
  int onAirYear=0;

  //放送季節
  @enumerated
  OnAirSeason season=OnAirSeason.spring;

  //ジャンル
  //多対多のリンク定義（中間テーブルの役割）
  final genres=IsarLinks<Genre>();

  //話数
  @Index(type: IndexType.value) //〇話以上という検索を掛けるかもしれないので書いておく
  int epNum=0;

  //分数
  int epTime=0;

  //評価（5段階）
  @Index(type: IndexType.value) //評価〇以上という検索を掛けるかもしれないので書いておく
  int evaluation=0;

  //メモ
  String memo = "";
}

enum AnimeStatus{
  never, //未視聴
  watching, //視聴中
  complete, //視聴済み
  cancel, //視聴中止
  interruption, //中断
}

//放送季節のenum
enum OnAirSeason{
  spring, //春
  summer, //夏
  autumn, //秋
  winter //冬
}