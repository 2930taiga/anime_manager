import 'package:anime_administration/providers/isar_provider.dart';
import 'package:flutter/material.dart'; // これがないとWidgetが使えない

//データベースに関するものをインポート
import 'package:anime_administration/models/genre.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

//登録ページ用のパーツを格納したコード
import 'package:anime_administration/parts/registar_parts.dart';

class RegistarPage extends StatelessWidget {

  const RegistarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController( //地上波か映画を選択できるタブを作成
      length: 2, //2タブ
      child: Scaffold(
        appBar: AppBar(
          title: const Text("登録"),
          leading: IconButton(
            onPressed: (){},
            icon: Icon(Icons.keyboard_backspace)
            ),
            actions: [ //保存ボタンを右上に置いてもいいかなって思った
              TextButton(
                onPressed: (){}, //一旦は戻るだけ
                child: Text(
                  "保存",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15
                  ),
                )
              )
            ],
        ), 
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.monitor),text: "アニメ",),
                Tab(icon: Icon(Icons.movie),text: "劇場版",)
              ],
            ),

            Expanded(
              child: TabBarView(
                children:[
                  TVRegistar(),
                  MovieRegistar()
                ]
              ),
            ),
          ],
        ),
      )
    );
  }
}

//ステータスのenum
enum Status{
  before,
  watching,
  complete,
  stop,
  pause
}
  
//入力中のデータを保持しておくクラスを宣言
class AnimeInputData{
  Status status = Status.before; //ステータス 
  String title = ""; //タイトル
  String titleKana = ""; //タイトル（かな）
  String date = ""; //日付
  int epNum = 0; //話数
  String epTime =""; //1話あたりの時間
  int evaliation = 0; //評価
  String memo=""; //メモ
}


class TVRegistar extends ConsumerStatefulWidget {
  const TVRegistar({super.key});

  @override
  ConsumerState<TVRegistar> createState() => _TVRegistarState();
}

class _TVRegistarState extends ConsumerState<TVRegistar> {

  final TextEditingController _titleController = TextEditingController(); //タイトル
  final TextEditingController _titleKanaController = TextEditingController(); //タイトル（かな）の入力を取得するコントローラを登録
  final TextEditingController _dateController = TextEditingController(); //日付を自動で入力するコントローラーを登録
  final TextEditingController _epNumController = TextEditingController(); //話数を自動で入力するコントローラーを登録
  final TextEditingController _epTimeController = TextEditingController(); //分数を自動で入力するコントローラーを登録
  final TextEditingController _memoController = TextEditingController(); //メモの内容を取得するコントローラ

  //SnackBarで表示するテキストのインスタンスを登録しておく------------------------------------------------------------------------
  var SnackBar_Save = SnackBar(content: Text("保存しました"));

  //ジャンル選択で必要となる変数を宣言しておく------------------------------------------------------------------------------------
  // //ジャンルのデータを保持するリストを宣言
  List<Genre> _genres=[];
  // //選択されているジャンルのidを保持しておく変数を宣言
  Set<int> selected_genre_id={};

  //データベース
  late final Isar isar;

  //ウィジェット立ち上げ時にデータベースからジャンルのデータを読み取る関数を宣言
  Future<void> load_db() async {
    isar=ref.read(isarProvider);
    //データベースからデータを取り出す
    final genres = await isar.genres.where().findAll();
    setState(() {
      _genres=genres;
    });
  }

  @override
  void initState(){
    super.initState(); //おまじない
    //データベース関連の処理の関数を実行
    load_db();
  }

  @override //メモリ開放処理
  void dispose(){
    _titleController.dispose();
    _titleKanaController.dispose();
    _dateController.dispose();
    _epTimeController.dispose();
    _epNumController.dispose();
    _memoController.dispose();
    super.dispose(); //おまじない
  }

  //----------------------------------------------------ここから登録のメイン画面
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // キーボード対策にこれを入れておくと安心
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const SizedBox(height: 20),

              //ステータス管理のドロップダウンメニュー
              StatusDropDownMenu(),

              const SizedBox(height: 20), //----------------------------------------

              //タイトル入力フォーム
              InputField(label: "タイトル", controller: _titleController),
              
              const SizedBox(height: 20), //----------------------------------------

              //タイトル（かな）入力フォーム
              InputField(label: "タイトル（かな）", controller: _titleKanaController),

              const SizedBox(height: 20), //----------------------------------------

              //日付入力フォーム
              InputField(label: "日付", controller: _dateController),
              //日付入力ボタン
              DateInputButtons(controller: _dateController),

              const SizedBox(height: 20), //----------------------------------------

              //ジャンル選択テキスト&ボタン
              SelectedGenreText(isar: isar, genres: _genres),

              const SizedBox(height: 20,), //----------------------------------------

              //話数入力欄
              InputField(label: "話数", controller: _epNumController),
              //話数入力ボタン
              EpNumInputButtons(controller: _epNumController),

              const SizedBox(height: 20,), //----------------------------------------

              //時間入力欄
              InputField(label: "1話あたりの時間", controller: _epTimeController),
              //時間入力ボタン
              EpTimeInputButtons(controller: _epTimeController),

              const SizedBox(height: 20), //----------------------------------------

              //評価ボタン
              EvaluationIcons(),

              const SizedBox(height: 20,), //----------------------------------------

              //メモ
              InputField(label: "メモ", controller: _memoController),

              const SizedBox(height: 20,), //----------------------------------------

            ],
          ),
        )
      ),
    );
  }
}

class MovieRegistar extends StatelessWidget { //地上波登録用の画面

  const MovieRegistar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: (){
              },
              child: const Text("保存して閉じる"),
            ),
          ),
          Text("映画登録")
        ],
      ),
    );
  }
}