//入力中のデータを保持しておくprovider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_administration/models/anime_input_class.dart';

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