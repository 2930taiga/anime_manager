import 'package:anime_administration/providers/isar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

//ナビゲーションページ
import 'pages/main_navigation.dart';

//データベースの構造モデルのスクリプト
import 'models/anime.dart';
import 'models/genre.dart';

void main() async { //メイン関数
  //--------データベースを扱うための前準備を書く-----------------
  //flutterが起動する前（画面を用意する前）にシステムを起動する
  WidgetsFlutterBinding.ensureInitialized();
  //データの保存場所を決定する
  final dir = await getApplicationDocumentsDirectory();
  //データベースの内容を読み込む
  final isar = await Isar.open(
    [GenreSchema,AnimeSchema], //これは.g.dartの中で指定されている
    directory:dir.path
  );

  //MyAppを動かす
  runApp(
    ProviderScope( //どのスクリプトからも使いまわせるように，Providerのisarを初期化
      overrides: [
        isarProvider.overrideWithValue(isar),
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  //isarを入れるための変数を用意する

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      home: MainNavigation(),
    );
  }
}
