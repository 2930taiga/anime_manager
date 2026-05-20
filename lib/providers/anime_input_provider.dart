//入力中のデータを保持しておくprovider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_administration/models/anime_input_class.dart';

//入力データを保持するprovider
final animeInputProvider = StateProvider<AnimeInputData>((ref){
  return AnimeInputData();
});