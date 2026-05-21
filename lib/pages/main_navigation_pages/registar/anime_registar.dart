import 'package:flutter/material.dart';

import 'package:anime_administration/providers/anime_input_provider.dart';
//データベースに関するものをインポート
import 'package:flutter_riverpod/flutter_riverpod.dart';

//登録ページ用のパーツを格納したコード
import 'package:anime_administration/parts/registar_parts.dart';

class AnimeRegistar extends ConsumerWidget{
  const AnimeRegistar({super.key});

  @override
  Widget build(BuildContext content, WidgetRef ref){
    //providerのインスタンスを作成
    final animeInput = ref.watch(animeInputProvider);
    final animeCorrectInput = ref.watch(animeCorrectInputProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("テスト1"),
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.arrow_back)
        ),
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
                onPressed: (){print(animeInput.epTime);},
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