//アニメのメイン情報のクラスを定義するコード

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

  //タイトル
  late String title;
  //タイトルかな
  late String titleKana;

  //ステータス
  @enumerated
  late AnimeStatus status;

  //話数
  @Index(type: IndexType.value) //〇話以上という検索を掛けるかもしれないので書いておく
  int episode=0;
  //分数
  int durationMinutes=0;

  //日付
  DateTime updateAt=DateTime.now();

  //評価（5段階）
  @Index(type: IndexType.value) //評価〇以上という検索を掛けるかもしれないので書いておく
  int evaluation=0;

  //多対多のリンク定義（中間テーブルの役割）
  final genres=IsarLinks<Genre>();
}

enum AnimeStatus{
  never, //未視聴
  watching, //視聴中
  complete, //視聴済み
  cancel, //視聴中止
  interruption, //中断
}