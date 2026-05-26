import 'package:flutter/material.dart';
//providerに関するものをインポート
import 'package:flutter_riverpod/flutter_riverpod.dart';
//ページに配置するパーツをインポート
import 'package:anime_administration/parts/genre_registar_parts.dart';
//見た目の設定に関するコードをインポート
import 'package:anime_administration/parameter_settings.dart';

//登録時のデータを保持するクラス
class GenreInputData{
  final String title;
  final int redValue;
  final int greenValue;
  final int blueValue;

  GenreInputData({
    this.title = "",
    this.redValue=0,
    this.greenValue=0,
    this.blueValue=0,
  });

  GenreInputData copyWith({
    String? title,
    int? redValue,
    int? greenValue,
    int? blueValue,
  }){
    return GenreInputData(
      title: title ?? this.title,
      redValue: redValue ?? this.redValue,
      greenValue: greenValue ?? this.greenValue,
      blueValue: blueValue ?? this.blueValue,
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

class GenreRegistar extends ConsumerStatefulWidget {
  //ジャンルを新しく登録するかどうか
  final bool initialNewAdd ;

  const GenreRegistar({super.key,required this.initialNewAdd});

  @override
  ConsumerState<GenreRegistar> createState() => _GenreRegistarState();
}

class _GenreRegistarState extends ConsumerState<GenreRegistar> {
  //初期化でコピーする
  late bool newAdd;

  @override
  void initState(){
    super.initState();
    newAdd = widget.initialNewAdd;
  }

  @override
  Widget build(BuildContext context) {
    //providerのインスタンスを作成
    final genreInput = ref.watch(genreInputProvider);
    final genreCorrectInput = ref.watch(genreCorrectInputProvider);

    //保存に関する関数を定義
    void Save(){
      if(genreCorrectInput.isInvalid==true){ //保存できる

      }
      else{ //保存できない
        //入力に不備がある箇所を取得
        List<String> erroeParameters = genreCorrectInput.invalidFields;

        //パラメータのリスト
        List<String> parametors = [
          "title",
          "redValue",
          "greenValue",
          "blueValue"
        ];

        //パラメータのリスト（日本語）
        List<String> parametorsJP = [
          "タイトル",
          "Red",
          "Green",
          "Blue"
        ];

        //エラーのパラメータ
        Map<String ,bool> errorParametorFlags = {
          "title" : true,
          "redValue" : true,
          "greenValue" : true,
          "blueValue" : true
        };

        //エラー判定を行い，エラーメッセージを作成
        if(erroeParameters.contains("title")){ //タイトルに不備
          errorParametorFlags["title"]=false;
        }
        if(erroeParameters.contains("redValue")){ //赤に不備
          errorParametorFlags["redValue"]=false;
        }
        if(erroeParameters.contains("greenValue")){ //緑に不備
          errorParametorFlags["greenValue"]=false;
        }
        if(erroeParameters.contains("blueValue")){ //青に不備
          errorParametorFlags["blueValue"]=false;
        }

        //エラーメッセージに表示するエラー項目を作成
        List<Widget> errorParameterWidgets = List.generate(errorParametorFlags.length,(index){
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
        
        //ダイアログを表示
        showDialog(context: context,
          builder: (content){
            return Dialog(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 330,
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
        title: Text("ジャンル登録"),
        actions: [
          TextButton(
            onPressed: Save,
            child: Text(
              "保存",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16
              ),
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: AlignmentGeometry.topCenter,
          child: Column(
            children: [

              SizedBox(height: 20,),

              //ジャンル名入力欄
              TitleIputField(),

              SizedBox(height: 20,),

              //プレビュー画面
              PreviewColor(),

              SizedBox(height: 20,),

              //色入力欄
              SizedBox( 
                width: MediaQuery.of(context).size.width*0.9,
                child: Column(
                  children: [

                    //赤色
                    RedInputField(),

                    //緑
                    GreenInputField(),

                    //青
                    BlueInputField(),


                  ],
                ),
              ),

              SizedBox(height: 20,),

              ColorPickIcons()
            ],
          ),
        ),
      )
    );
  }
}