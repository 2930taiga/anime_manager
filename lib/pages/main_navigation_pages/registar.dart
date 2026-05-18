import 'package:anime_administration/providers/isar_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // これがないとWidgetが使えない

//データベースに関するものをインポート
import 'package:anime_administration/models/genre.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

//登録ページ用のパーツを格納したコード
import 'package:anime_administration/parts/registar_parts.dart';

//登録ページ

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

  //登録画面で内容を保持する変数を宣言しておく-----------------------------------------------------------------------------------

  //SnackBarで表示するテキストのインスタンスを登録しておく------------------------------------------------------------------------
  var SnackBar_Save = SnackBar(content: Text("保存しました"));

  //選択されているジャンルを表示するTextFieldの文字列を格納しておく変数を宣言------------------------------------------------------
  String select_genre_text="ジャンルが選択されていません";

  //ジャンル選択で必要となる変数を宣言しておく------------------------------------------------------------------------------------
  // //ジャンルのデータを保持するリストを宣言
  List<Genre> _genres=[];
  // //選択されているジャンルのidを保持しておく変数を宣言
  Set<int> selected_genre_id={};

  //ウィジェット立ち上げ時にデータベースからジャンルのデータを読み取る関数を宣言
  Future<void> load_db() async {
    final Isar isar=ref.read(isarProvider);
    //データベースからデータを取り出す
    _genres = await isar.genres.where().findAll();
  }

  @override
  void initState(){
    super.initState(); //おまじない
    //データベース関連の処理の関数を実行
    load_db();
  }

  //-------------------------------------------------------------ボタンを押すと，ジャンル選択画面を表示する関数を宣言
  Future<void> select_genre (Isar isar) async {
    //ボタンの初期状態を読み取る
    //for文が何回回ったかカウントする変数を用意
    int i =0;
    //まずは中身が全てfalseのリストを用意
    List<bool> genre_select_state = List.filled(_genres.length, false);
    //selected_genre_idにそのidが含まれていたらfalse→trueに書き換える
    for (Genre genre_instance in _genres){
      //ジャンルのインスタンスのidが選ばれているジャンルのidを保持するリストに含まれているかを確認
      if(selected_genre_id.contains(genre_instance.id)){
        genre_select_state[i]=true;
      }
      //周回をカウント
      i=i+1;
    }

    showDialog(
      context: context,
      builder: (context){
        return StatefulBuilder(
          builder: (context,setStateDialog){
            return Dialog(
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.9,
                height: 400,
                child: Column(
                  children: [

                    SizedBox(height: 20,),

                    Text(
                      "ジャンルを選択してください",
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),

                    SizedBox(height: 10,),

                    Expanded(
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: ListView(
                          children: List.generate(
                            _genres.length,
                            (index){
                              return SwitchListTile( //スイッチタイル部分
                                title: Text(_genres[index].name),
                                value: genre_select_state[index],
                                onChanged: (bool value){ //あるジャンルが選択されたときの処理
                                  setStateDialog((){
                                    //off→onになったとき
                                    if(value==true){
                                      //選択されているジャンルのidを保持しておくSet内にidを追加
                                      selected_genre_id.add(_genres[index].id);
                                    }
                                    //on→offになったとき
                                    else{
                                      selected_genre_id.remove(_genres[index].id);
                                    }
                                    //ダイアログを呼び出したときに仮で作成したboolのリストの中身を書き換える
                                    genre_select_state[index]=value;
                                  });
                                },
                              );
                            }
                          ),
                        )
                      )
                    ),

                    SizedBox(height: 10,),

                    SizedBox( //保存ボタン
                      width: MediaQuery.of(context).size.width*0.4,
                      child: ElevatedButton(
                        onPressed: (){
                          //ジャンル表示テキストに表示する用のテキストを作成
                          //初期文字列
                          String genre_text_temp="";
                          for(int _id in selected_genre_id){
                            //選択されているジャンルのidから，文字列を作成
                            genre_text_temp += _genres.firstWhere((g) => g.id == _id).name; //データベースのデータをコピーしたリストからidが一致するものを探し出し，nameを取得する
                            //","で区切る
                            genre_text_temp += "，";
                          }

                          //最後の","を取る
                          if(genre_text_temp!=""){
                            genre_text_temp = genre_text_temp.substring(0 , genre_text_temp.length - 1 );
                          }

                          //もし文字列が空白のままなら，「ジャンルが選択されていません」に戻す
                          if(genre_text_temp == ""){
                            genre_text_temp = "ジャンルが選択されていません";
                          }

                          //選択されているジャンルを表示するTextの中身を書き換える
                          setState(() {
                            select_genre_text=genre_text_temp;
                          });
                          
                          //戻る
                          Navigator.pop(context);
                          //テキストのフォーカスを外す
                          FocusScope.of(context).unfocus();
                        },
                        child: Text("保存")
                      ),
                    ),

                    SizedBox(height: 20,)
                  ],
                ),
              ),
            );
          }
        );
      }
    );
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

              SizedBox( //-------------------------------------------------ステータス（プルダウン）
                width: MediaQuery.of(context).size.width * 0.9,
                child: DropdownMenu(
                  label: Text("ステータス"),
                  dropdownMenuEntries: const[
                    DropdownMenuEntry(value: 0, label: "未視聴"),
                    DropdownMenuEntry(value: 1, label: "視聴中"),
                    DropdownMenuEntry(value: 2, label: "視聴済"),
                    DropdownMenuEntry(value: 3, label: "視聴中止"),
                    DropdownMenuEntry(value: 4, label: "中断"),
                  ]
                  ),
              ),

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

              Container( //------------------------------------------------ジャンル選択欄（選択済みジャンル表示欄）
                height: 55,
                width: MediaQuery.of(context).size.width*0.9,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(7)
                ),
                child: Center(
                  child: Text(
                    select_genre_text,

                    style: TextStyle(
                      fontSize: 17
                    ),
                  ),
                )
                
              ),

              SizedBox(height: 8,), //----------------------------------------

              SizedBox(
                width: MediaQuery.of(context).size.width*0.9,
                child: ElevatedButton(
                  onPressed: (){
                    final Isar isar = ref.read(isarProvider);                
                    select_genre(isar);
                  },
                  child: Text(
                    "ジャンル選択"
                  )
                ),
              ),

              const SizedBox(height: 20,), //----------------------------------------

              //話数入力欄
              InputField(label: "話数", controller: _epNumController),
              //話数入力ボタン
              EpNumInputButtons(controller: _epNumController),

              SizedBox(height: 20,), //----------------------------------------

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

              SizedBox(height: 20,), //----------------------------------------

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