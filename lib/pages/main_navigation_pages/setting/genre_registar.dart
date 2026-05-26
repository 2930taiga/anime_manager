import 'package:flutter/material.dart';
//providerに関するものをインポート
import 'package:flutter_riverpod/flutter_riverpod.dart';
//ページに配置するパーツをインポート
import 'package:anime_administration/parts/genre_registar_parts.dart';

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
    this.redValue=false,
    this.greenValue=false,
    this.blueValue=false,
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

  //RGBの値
  double redValue=0;
  double greenValue=0;
  double blueValue=0;

  //テキストフィールドのコントローラ
  TextEditingController _redController = TextEditingController();
  TextEditingController _greenController = TextEditingController();
  TextEditingController _blueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //providerのインスタンスを作成
    final genreInput = ref.watch(genreInputProvider);
    final genreCorrectInput = ref.watch(genreCorrectInputProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("ジャンル登録"),
        actions: [
          TextButton(
            onPressed:(){},
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

              SizedBox( //色入力欄
                width: MediaQuery.of(context).size.width*0.9,
                child: Column(
                  children: [

                    //赤色
                    RedInputField(),

                    //緑
                    GreenInputField(),

                    //青
                    BlueInputField()

                  ],
                ),
              ),
              TextButton(
                onPressed: (){
                  print(genreInput.blueValue);
                },
                child: Text("テスト")
              ),
              TextButton(
                onPressed: (){
                  print(genreCorrectInput.blueValue);
                },
                child: Text("テスト")
              )
            ],
          ),
        ),
      )
    );
  }
}