import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_administration/models/genre.dart';
import 'package:flutter/material.dart';

//登録時のデータを保持するクラス
class GenreInputData{
  final String title;
  final int redValue;
  final int greenValue;
  final int blueValue;
  final IconData iconData;
  final IconShape iconShape;

  GenreInputData({
    this.title = "",
    this.redValue=0,
    this.greenValue=0,
    this.blueValue=0,
    this.iconData = Icons.fiber_manual_record,
    this.iconShape = IconShape.circle
  });

  GenreInputData copyWith({
    String? title,
    int? redValue,
    int? greenValue,
    int? blueValue,
    IconData? iconData,
    IconShape? iconShape,
  }){
    return GenreInputData(
      title: title ?? this.title,
      redValue: redValue ?? this.redValue,
      greenValue: greenValue ?? this.greenValue,
      blueValue: blueValue ?? this.blueValue,
      iconData: iconData ?? this.iconData,
      iconShape: iconShape ?? this.iconShape,
    );
  }
}

//登録時に正しいデータが登録されているかを確認するクラス
class GenreCorrectInputData{
  final bool title;
  final bool redValue;
  final bool greenValue;
  final bool blueValue;

  GenreCorrectInputData({
    this.title=false,
    this.redValue=true,
    this.greenValue=true,
    this.blueValue=true,
  });

  GenreCorrectInputData copyWith({
    bool? title,
    bool? redValue,
    bool? greenValue,
    bool? blueValue,
  }){
    return GenreCorrectInputData(
      title: title ?? this.title,
      redValue: redValue ?? this.redValue,
      greenValue: greenValue ?? this.greenValue,
      blueValue: blueValue ?? this.blueValue,
    );
  }

    //全てtrueか確認する
  bool get isInvalid =>
  title &&
  redValue &&
  greenValue &&
  blueValue;

  Map<String,bool> get validationMap => {
    "title":title,
    "redValue":redValue,
    "greenValue":greenValue,
    "blueValue":blueValue,
  };

  //falseの項目だけ抽出
  List<String> get invalidFields =>
    validationMap.entries
      .where((e) => e.value == false)
      .map((e) => e.key)
      .toList();
}

//入力データ保持用のprovider
//入力データを保持するprovider
//autoDisposeを追記することによって，画面内からこのproviderの監視者がいなくなったら，値を自動的にリセットする
final genreInputProvider = StateProvider.autoDispose<GenreInputData>((ref){
  return GenreInputData();
});

//入力データ保持用のprovider
//入力データを保持するprovider
//autoDisposeを追記することによって，画面内からこのproviderの監視者がいなくなったら，値を自動的にリセットする
final genreCorrectInputProvider = StateProvider.autoDispose<GenreCorrectInputData>((ref){
  return GenreCorrectInputData();
});