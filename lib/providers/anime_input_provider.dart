//入力中のデータを保持しておくprovider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';

//ステータスのenum
enum Status{
  never,
  watching,
  complete,
  cancel,
  interruption
}

//放送季節のenum
enum OnAirSeason{
  spring,
  summer,
  autumn,
  winter
}

class AnimeInputData {
  final Status status;
  final String title;
  final String titleKana;
  final DateTime date;
  final int onAirYear;
  final OnAirSeason season;
  final Set<int> genreId;
  final int epNum;
  final int epTime;
  final int evaluation;
  final String memo;

  AnimeInputData({
    this.status = Status.never,
    this.title="",
    this.titleKana="",
    DateTime? date ,
    this.onAirYear=2000,
    this.season = OnAirSeason.spring,
    this.genreId = const <int>{},
    this.epNum=0,
    this.epTime=0,
    this.evaluation=0,
    this.memo=""
  }):date = date?? DateTime.now();

  AnimeInputData copyWith({
    Status? status,
    String? title,
    String? titleKana,
    DateTime? date,
    int? onAirYear,
    OnAirSeason? season,
    Set<int>? genreId,
    int? epNum,
    int? epTime,
    int? evaluation,
    String? memo,
  }) {
    return AnimeInputData(
      status: status ?? this.status,
      title: title ?? this.title,
      titleKana: titleKana ?? this.titleKana,
      date: date ?? this.date,
      onAirYear: onAirYear ?? this.onAirYear,
      season: season ?? this.season,
      genreId: genreId ?? this.genreId,
      epNum: epNum ?? this.epNum,
      epTime: epTime ?? this.epTime,
      evaluation: evaluation ?? this.evaluation,
      memo: memo ?? this.memo,
    );
  }
}


//正しい値を入力しているかを判定するクラス
@immutable
class AnimeCorrectInputData {
  final bool status;
  final bool title;
  final bool titleKana;
  final bool date;
  final bool onAirYear;
  final bool season;
  final bool genreId;
  final bool epNum;
  final bool epTime;
  final bool evaluation;
  final bool memo;

  const AnimeCorrectInputData({
    this.status = false,
    this.title = false,
    this.titleKana= false,
    this.date = false,
    this.onAirYear = false,
    this.season = false,
    this.genreId = false,
    this.epNum = false,
    this.epTime = false,
    this.evaluation = true,
    this.memo = true
  });

  AnimeCorrectInputData copyWith({
    bool? status,
    bool? title,
    bool? titleKana,
    bool? date,
    bool? onAirYear,
    bool? season,
    bool? genreId,
    bool? epNum,
    bool? epTime,
    bool? evaluation,
    bool? memo,
  }) {
    return AnimeCorrectInputData(
      status: status ?? this.status,
      title: title ?? this.title,
      titleKana: titleKana ?? this.titleKana,
      date: date ?? this.date,
      onAirYear: onAirYear ?? this.onAirYear,
      season: season ?? this.season,
      genreId: genreId ?? this.genreId,
      epNum: epNum ?? this.epNum,
      epTime: epTime ?? this.epTime,
      evaluation: evaluation ?? this.evaluation,
      memo: memo ?? this.memo,
    );
  }

  //全てtrueかを判定する
  bool get isInvalid => 
  status &&
  title &&
  titleKana &&
  date &&
  onAirYear &&
  season &&
  genreId &&
  epNum &&
  epTime &&
  evaluation &&
  memo;

  //どこがfalseかを取得する
  Map<String, bool> get validationMap => {
    'status': status,
    'title': title,
    'titleKana': titleKana,
    'date': date,
    'onAirYear': onAirYear,
    'season': season,
    'genreId': genreId,
    'epNum': epNum,
    'epTime': epTime,
    'evaluation': evaluation,
    'memo': memo,
  };

  // falseの項目だけ抽出
  List<String> get invalidFields =>
    validationMap.entries
      .where((e) => e.value == false)
      .map((e) => e.key)
      .toList();
}

//入力データを保持するprovider
//autoDisposeを追記することによって，画面内からこのproviderの監視者がいなくなったら，値を自動的にリセットする
final animeInputProvider = StateProvider.autoDispose<AnimeInputData>((ref){
  return AnimeInputData();
});

//入力データが正しいかを保持するprovider
//autoDisposeを追記することによって，画面内からこのproviderの監視者がいなくなったら，値を自動的にリセットする
final animeCorrectInputProvider = StateProvider.autoDispose<AnimeCorrectInputData>((ref){
  return AnimeCorrectInputData();
});