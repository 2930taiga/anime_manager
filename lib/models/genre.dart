//ジャンルのクラスを定義するコード
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
}

enum IconShape{
  circle,
  square,
  triangle,
  star,
  x,
  plus
}