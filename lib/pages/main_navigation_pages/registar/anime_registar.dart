import 'package:flutter/material.dart';
//providerに関するコードをインポート
import 'package:anime_administration/providers/anime_input_provider.dart';
//データベースに関するものをインポート
import 'package:flutter_riverpod/flutter_riverpod.dart';
//登録ページ用のパーツを格納したコード
import 'package:anime_administration/parts/anime_registar_parts.dart';

class AnimeRegistar extends ConsumerWidget{
  const AnimeRegistar({super.key});

  @override
  Widget build(BuildContext content, WidgetRef ref){
    //providerのインスタンスを作成
    final animeInput = ref.watch(animeInputProvider);
    final animeCorrectInput = ref.watch(animeCorrectInputProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("アニメ登録"),
        leading: IconButton( //戻るボタン
          onPressed: (){
          },
          icon: Icon(Icons.arrow_back)
        ),
        actions: [
          TextButton(
            onPressed: (){},
            child: Text(
              "保存",
              style: TextStyle(
                color: Colors.grey
              ),
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const SizedBox(height: 20,),//-----------------------------------------------------

              //ステータス
              StatusDropDownMenu(),

              const SizedBox(height: 20,),//-----------------------------------------------------

              //タイトル
              InputFieldTitle(),

              const SizedBox(height: 20,),//-----------------------------------------------------

              //タイトルかな
              InputFieldTitleKana(),

              const SizedBox(height: 20,),//-----------------------------------------------------

              //日付
              InputFieldDate(),

              const SizedBox(height: 20,),//-----------------------------------------------------

              //ジャンル選択ボタン
              SelectedGenreText(),

              const SizedBox(height: 20,),//-----------------------------------------------------

              //話数
              InputFieldEpNum(),

              const SizedBox(height: 20,),//-----------------------------------------------------

              //時間
              InputFieldEpTime(),
              
              const SizedBox(height: 20,),//-----------------------------------------------------

              //評価
              EvaluationIcons(),

              const SizedBox(height: 20,),//-----------------------------------------------------
              
              //メモ
              InputFieldMemo(),

              TextButton(
                onPressed: (){print(animeInput.genreId);},
                child: Text("テスト用")
              ),
              TextButton(
                onPressed: (){print(animeCorrectInput.date);},
                child: Text("テスト用1")
              ),
            ],
          ),
        ),
      ),
    );
  }
}