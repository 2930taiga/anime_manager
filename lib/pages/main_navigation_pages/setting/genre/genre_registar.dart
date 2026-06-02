import 'package:anime_administration/models/genre.dart';
import 'package:flutter/material.dart';
//providerに関するものをインポート
import 'package:flutter_riverpod/flutter_riverpod.dart';
//ページに配置するパーツをインポート
import 'package:anime_administration/parts/genre_registar_parts.dart';
//見た目の設定に関するコードをインポート
import 'package:anime_administration/parameter_settings.dart';
//isarのprovider
import 'package:anime_administration/providers/isar_provider.dart';

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

class GenreRegistar extends ConsumerStatefulWidget {
  //ジャンルを新しく登録するかどうか
  final bool initialNewAdd ;
  //タイトルの初期値
  final String title;
  //RGBの初期値（ジャンルを編集する場合）
  final List<int> rgbColors;
  //データベースのインデックス（ジャンルを編集する場合）
  final int id;
  //アイコンの初期値（ジャンルを編集する場合）
  final IconData iconData;
  final IconShape iconShape;

  const GenreRegistar({super.key,required this.initialNewAdd,required this.title,required this.rgbColors,required this.id,required this.iconData, required this.iconShape});

  @override
  ConsumerState<GenreRegistar> createState() => _GenreRegistarState();
}

class _GenreRegistarState extends ConsumerState<GenreRegistar> {  
  //初期化でコピーする
  late bool newAdd;
  late String _title;
  late List<int> _rgbColors;
  late int _id;
  late IconData _iconData;
  late IconShape _iconShape;

  @override
  void initState(){
    super.initState();
    newAdd = widget.initialNewAdd;
    _title = widget.title;
    _rgbColors = widget.rgbColors;
    _id = widget.id;
    _iconData = widget.iconData;
    _iconShape = widget.iconShape;

    //編集モードなら初期値を入力
    //build終了後に実行
    WidgetsBinding.instance.addPostFrameCallback((_){
      if(newAdd == false){
        ref.read(genreInputProvider.notifier).state=
        GenreInputData(
          title: _title,
          redValue: _rgbColors[0],
          greenValue: _rgbColors[1],
          blueValue: _rgbColors[2],
          iconData: _iconData,
          iconShape: _iconShape
        );
      }
    });
  }

  //保存するときに，テキストフィールドが空，または内容が重複しているとアラートを出す関数を定義
  void text_error_alert(String text){
    showDialog(context: context,
      builder: (_){
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 240,
            child: Column(
              children: [
                SizedBox(height: 30,),

                Text(
                  "エラー",
                  style: TextStyle(
                    fontSize: 27,
                    color: Texts.errorMessageColor,
                    fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(height: 15,),

                Text(
                  "「$text」は\n既に登録されています",
                  style: TextStyle(
                    color: Texts.subMessageColor,
                    fontSize: 17
                  ),
                ),

                SizedBox(height: 20,),

                SizedBox(
                  width: MediaQuery.of(context).size.width*0.6,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ElevatedButtons.backgroundColor
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                        color: ElevatedButtons.fontColor,
                        fontSize: 18
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    //providerのインスタンスを作成
    final genreCorrectInput = ref.watch(genreCorrectInputProvider);
    final genreInput = ref.watch(genreInputProvider);
    final isar=ref.read(isarProvider);

    //保存に関する関数を定義
    Future<void> Save() async {
      if(genreCorrectInput.isInvalid==true){ //保存できる
        //.trim()を付けることで，前後の空白をカット
        final String genreName = ref.read(genreInputProvider.notifier).state.title.trim();

        //ジャンル名が空ならアラートを出す
        if(genreName.isEmpty){
          text_error_alert("ジャンル名が入力されていません");
          return;
        }

        //実際に保存する処理を書いていく
        if(newAdd==true){ //新しく登録する場合
          try{
            //新しいデータのインスタンスを作成
            await isar.writeTxn(() async {
              final newGenre = Genre()
              ..name = genreInput.title
              ..redValue = genreInput.redValue
              ..greenValue = genreInput.greenValue
              ..blueValue = genreInput.blueValue
              ..iconShape = genreInput.iconShape;

              //データベースに保存する
              await isar.genres.put(newGenre);
            });
            //戻る
            Navigator.pop(context);

            //スナックバーにメッセージを表示
            showSnackBar(context, "ジャンル「$genreName」を保存しました");
          }
          catch(e){
            text_error_alert(genreName);
          }
        }

        else{ //編集する場合
          //元のデータと新しいデータ
          String beforeName = _title;
          String afterName = genreInput.title;
          try{
            //新しいデータのインスタンスを作成
            await isar.writeTxn(() async{
              final newGenre = Genre()
              ..id = _id
              ..name = genreInput.title
              ..redValue = genreInput.redValue
              ..greenValue = genreInput.greenValue
              ..blueValue = genreInput.blueValue
              ..iconShape = genreInput.iconShape;

              //データベースに保存する
              await isar.genres.put(newGenre);
            });

            //戻る
            Navigator.pop(context);

            //スナックバーにメッセージを表示
            showSnackBar(context, "「$beforeName」を「$afterName」に変更しました");
          }
          catch(e){
            text_error_alert(genreName);
          }
        }
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
              TitleText(titleText: "プレビュー"),
              SizedBox(height: 10,),
              PreviewColor(),

              SizedBox(height: 20,),

              //色入力欄
              TitleText(titleText: "カラー"),
              SizedBox(height: 10,),
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

              //カラーピッカーアイコン
              TitleText(titleText: "デフォルトカラー"),
              SizedBox(height: 10,),
              ColorPickIcons(),

              SizedBox(height: 20,),

              //形選択アイコン
              TitleText(titleText: "アイコン"),
              SizedBox(height: 10,),
              ShapePickIcons(),

              ElevatedButton(onPressed: (){print(genreInput.title);}, child: Text("テスト")),

              //下までスクロールできるようにするためのbox
              SizedBox(height: 50,)
            ],
          ),
        ),
      )
    );
  }
}