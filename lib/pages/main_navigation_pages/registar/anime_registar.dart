import 'package:flutter/material.dart';
//providerに関するコードをインポート
import 'package:anime_administration/providers/anime_input_provider.dart';
//データベースに関するものをインポート
import 'package:flutter_riverpod/flutter_riverpod.dart';
//登録ページ用のパーツを格納したコード
import 'package:anime_administration/parts/anime_registar_parts.dart';
//UIの設定に関するパラメータをインポート
import 'package:anime_administration/parameter_settings.dart';

class AnimeRegistar extends ConsumerWidget{
  const AnimeRegistar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    //providerのインスタンスを作成
    final animeInput = ref.watch(animeInputProvider);
    final animeCorrectInput = ref.watch(animeCorrectInputProvider);

    //保存に関する関数を定義
    void Save(){
      //保存できる状態かを確認する
      if(animeCorrectInput.isInvalid==true){ //保存できる

      }
      else{ //保存できない
        //入力に不備がある箇所を取得
        List<String> erroeParameters = animeCorrectInput.invalidFields;
        //エラーパラメータ
        List<String> errorParametorText=[];

        //エラーメッセージを作成
        if(erroeParameters.contains("status")){ //ステータスに不備
          errorParametorText.add("ステータス");
        }
        if(erroeParameters.contains("title")){ //タイトルに不備
          errorParametorText.add("タイトル");
        }
        if(erroeParameters.contains("titleKana")){ //タイトル（かな）に不備
          errorParametorText.add("タイトル（かな）");
        }
        if(erroeParameters.contains("genre")){ //ジャンルに不備
          errorParametorText.add("ジャンル");
        }
        if(erroeParameters.contains("date")){ //日付に不備
          errorParametorText.add("日付");
        }
        if(erroeParameters.contains("epNum")){ //話数に不備
          errorParametorText.add("話数");
        }
        if(erroeParameters.contains("epTime")){ //時間に不備
          errorParametorText.add("1話あたりの時間（分）");
        }
        if(erroeParameters.contains("evaluation")){ //評価に不備
          errorParametorText.add("評価");
        }

        //エラーメッセージに表示するエラー項目を作成
        List<Widget> errorParameterWidgets = 
          List.generate(errorParametorText.length,(index){
            return SizedBox(
              child: Row(
                children: [
                  Icon(
                    Icons.highlight_off,
                    color: Colors.red,
                  ),

                  SizedBox(width: MediaQuery.of(context).size.width*0.02,),

                  Expanded(
                    child: Text(
                      errorParametorText[index],
                      style: TextStyle(
                        fontSize: 17
                      ),
                    )
                  )
                ],
              ),
            );
          });

        //ダイアログを表示
        showDialog(context: context,
        builder: (content){
          return Dialog(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 400,
              child: Column(
                children: [

                  SizedBox(height: 30,),
                  
                  Text( //タイトル
                    "エラー",
                    style: TextStyle(
                      fontSize: 25,
                      color: Texts.errorMessageColor,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  SizedBox(height: 15,),

                  Text( //サブメッセージ
                    "以下の項目に有効な値を入力してください",
                    style: TextStyle(
                      color: Texts.subMessageColor,
                      fontSize: 15
                    ),
                  ),
                  
                  SizedBox(height: 20,),

                  Expanded( //エラー項目を表示する
                    child: Row(
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width * 0.05,),

                        Expanded(
                        child: Column(
                          children: errorParameterWidgets,
                        )
                      ),

                        SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                      ],
                    )
                  ),

                  SizedBox(height: 20,),

                  SizedBox( //OKボタン
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ElevatedButtons.backgroundColor
                      ),
                      child: Text(
                        "OK",
                        style: TextStyle(
                          color: ElevatedButtons.fontColor,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 25,),
                ],
              ),
            ),
          );
        }
        );
      }
    }

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
            onPressed: Save,
            child: Text(
              "保存",
              style: TextStyle(
                color: Colors.blue,
                //fontWeight: FontWeight.bold,
                fontSize: 16
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

              // TextButton(
              //   onPressed: (){
              //     print(animeInput.genreId);
              //   },
              //   child: Text("テスト用")
              // ),
              // TextButton(
              //   onPressed: (){
              //     print(animeCorrectInput.date);
              //   },
              //   child: Text("テスト用1")
              // ),
            ],
          ),
        ),
      ),
    );
  }
}