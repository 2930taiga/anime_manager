import 'package:anime_administration/models/anime.dart';
import 'package:anime_administration/models/genre.dart';
import 'package:anime_administration/providers/isar_provider.dart';
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
    final isar = ref.watch(isarProvider);

    //保存に関する関数を定義
    Future<void> Save () async {
      //保存できる状態かを確認する
      if(animeCorrectInput.isInvalid==true){ //保存できる
        //アニメのモデルを生成
        final anime = Anime()
        ..status = animeInput.status
        ..title = animeInput.title
        ..titleKana = animeInput.titleKana
        ..date = animeInput.date
        ..onAirYear = animeInput.onAirYear
        ..season = animeInput.season
        ..epNum = animeInput.epNum
        ..epTime = animeInput.epTime
        ..evaluation = animeInput.evaluation
        ..memo = animeInput.memo;

        await isar.writeTxn(() async {
          //アニメ本体を保存
          await isar.animes.put(anime);

          //選択されたジャンルを取得
          final genres = await isar.genres.getAll(
            animeInput.genreId.toList(),
          );

          //nullを除去してリンクへ追加
          anime.genres.addAll(
            genres.whereType<Genre>(),
          );

          //リンク保存
          await anime.genres.save();

          // print(animeInput.title);

          // print("ここまで実行されました");
        });

        //スナックバーにメッセージを表示
        showSnackBar(context, "「${animeInput.title}」を保存しました");

        //画面を戻る
        Navigator.pop(context);
      }
      else{ //保存できない
        //入力に不備がある箇所を取得
        List<String> erroeParameters = animeCorrectInput.invalidFields;

        //パラメータのリスト
        List<String> parametors = [
          "status",
          "title",
          "titleKana",
          "date",
          "onAirYear",
          "season",
          "genre",
          "epNum",
          "epTime",
          "evaluation",
          "memo"
        ];

        //パラメータのリスト（日本語）
        List<String> parametorsJP = [
          "ステータス",
          "タイトル",
          "タイトル（かな）",
          "日付",
          "放送年",
          "季節",
          "ジャンル",
          "話数",
          "1話あたりの時間",
          "評価",
          "メモ"
        ];

        //エラーのパラメータ
        Map<String,bool> errorParametorFlags = {
          "status" : true,
          "title" : true,
          "titleKana" : true,
          "date" : true,
          "onAirYear" : true,
          "season" : true,
          "genre" : true,
          "epNum" : true,
          "epTime" : true,
          "evaluation" : true,
          "memo" : true
        };

        //エラー判定を行い，エラーメッセージを作成
        if(erroeParameters.contains("status")){ //ステータスに不備
          errorParametorFlags["status"]=false;
        }
        if(erroeParameters.contains("title")){ //タイトルに不備
          errorParametorFlags["title"]=false;
        }
        if(erroeParameters.contains("titleKana")){ //タイトル（かな）に不備
          errorParametorFlags["titleKana"]=false;
        }
        if(erroeParameters.contains("genreId")){ //ジャンルに不備
          errorParametorFlags["genre"]=false;
        }
        if(erroeParameters.contains("date")){ //日付に不備
          errorParametorFlags["date"]=false;
        }
        if(erroeParameters.contains("onAirYear")){ //放送年に不備
          errorParametorFlags["onAirYear"]=false;
        }
        if(erroeParameters.contains("season")){ //放送時期に不備
          errorParametorFlags["season"]=false;
        }
        if(erroeParameters.contains("epNum")){ //話数に不備
          errorParametorFlags["epNum"]=false;
        }
        if(erroeParameters.contains("epTime")){ //時間に不備
          errorParametorFlags["epTime"]=false;
        }
        if(erroeParameters.contains("evaluation")){ //評価に不備
          errorParametorFlags["evaluation"]=false;
        }

        //エラーメッセージに表示するエラー項目を作成
        List<Widget> errorParameterWidgets = 
          List.generate(errorParametorFlags.length,(index){
            return SizedBox(
              child: Row(
                children: [
                  Icon(
                    errorParametorFlags[parametors[index]] ?? false
                    ? Icons.done
                    : Icons.close,
                    color: errorParametorFlags[parametors[index]] ?? false
                    ? Colors.lightGreen
                    :Colors.red,
                  ),

                  SizedBox(width: MediaQuery.of(context).size.width*0.02,),

                  Expanded(
                    child: Text(
                      parametorsJP[index],
                      style: TextStyle(
                        fontSize: 17
                      ),
                    )
                  )
                ],
              ),
            );
          });

        //print("ここまで実行");
        //ダイアログを表示
        showDialog(context: context,
        builder: (content){
          return Dialog(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 490,
              child: Column(
                children: [

                  SizedBox(height: 30,),
                  
                  Text( //タイトル
                    "エラー",
                    style: TextStyle(
                      fontSize: 27,
                      color: Texts.errorMessageColor,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  SizedBox(height: 15,),

                  Text( //サブメッセージ
                    "入力を確認してください",
                    style: TextStyle(
                      color: Texts.subMessageColor,
                      fontSize: 17
                    ),
                  ),
                  
                  SizedBox(height: 20,),

                  Expanded( //エラー項目を表示する
                    child: Row(
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width * 0.1,),

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
                        FocusManager.instance.primaryFocus?.unfocus();
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
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back)
        ),
        actions: [
          // IconButton(
          //   onPressed: (){

          //   },
          //   icon: Icon(
          //     Icons.star,
          //     size: 30,
          //   )
          // ),
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

              InputOnAirDate(),

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

              //下までスクロールできるようにするためのbox
              const SizedBox(height: 50,),

              // TextButton(
              //   onPressed: (){
              //     print(animeInput.onAirYear);
              //   },
              //   child: Text("テスト用")
              // ),
              // TextButton(
              //   onPressed: (){
              //     print(animeCorrectInput.onAirYear);
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