import 'package:anime_administration/pages/main_navigation_pages/setting/genre_registar.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:anime_administration/models/genre.dart';
import 'package:anime_administration/providers/isar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingGenre extends ConsumerStatefulWidget {
  //コンストラクタを設定
  const SettingGenre({super.key});

  @override
  ConsumerState<SettingGenre> createState() => _SettingGenreState();
}

class _SettingGenreState extends ConsumerState<SettingGenre> {
  //テキストコントローラを登録
  final TextEditingController _genreTextController = TextEditingController();
  @override //メモリ開放
  void dispose() {
    _genreTextController.dispose(); // 使い終わったらメモリを解放するお作法
    super.dispose(); //親クラスにメモリが解放されたことを伝える
  }

  //ダイアログを開いてジャンル追加画面を表示する関数を作成
  void addGenre(){
    _genreTextController.clear();
    showDialog(
      context: context,
      builder:(context){
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            height: 250,
            child: Column(
              children: [
                SizedBox(height: 20,),

                Center(child: Text( //ダイアログの一番上に出すタイトル
                  "ジャンルを登録してください",
                  style: TextStyle(
                    fontSize: 20
                  ),
                  ),
                ),

                SizedBox(height: 40,),

                SizedBox( //ジャンル名入力欄
                  width: MediaQuery.of(context).size.width*0.6,
                  //height: ,
                  child: TextField(
                    controller: _genreTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "ジャンル名を入力"
                    ),
                  ),
                ),

                SizedBox(height: 30,),

                SizedBox( //保存ボタン
                  width: MediaQuery.of(context).size.width*0.55,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async { //保存する処理を書く
                    final Isar isar=ref.read(isarProvider);
                    //.trim()を付けることで，前後の空白をカット
                    final String genreName = _genreTextController.text.trim();
                      if(genreName.isEmpty){
                        //ジャンル名が空ならアラートを出す
                        text_error_alert("ジャンル名が入力されていません");
                        return;
                      }

                      //実際に保存する処理を書いていく
                      try{
                        await isar.writeTxn(() async {
                          //新しいデータのインスタンスを作成
                          final newGenre = Genre()..name = genreName;

                          //データベースに保存する
                          await isar.genres.put(newGenre);

                          //保存が完了したら画面を閉じてメッセージを出す
                          _genreTextController.clear(); //テキストフィールドを空に
                          Navigator.pop(context); //画面を閉じる
                          ScaffoldMessenger.of(context).showSnackBar( //スナックバーにメッセージを表示
                            SnackBar(
                              content: Text("ジャンル「$genreName」を保存しました")
                            )
                          );
                        });
                      }
                      catch(e){
                        text_error_alert("ジャンル「$genreName」は既に登録されています");
                      }
                    },
                    child: Text(
                      "保存",
                      style: TextStyle(
                        fontSize: 13
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  //保存するときに，テキストフィールドが空，または内容が重複しているとアラートを出す関数を定義
  void text_error_alert(String message){
    showDialog(
      context: context,
      builder: (_){
        return AlertDialog(
          title: Text("入力エラー"),
          content: Text(message),
          actions: [
            TextButton(onPressed: (){ //「OK」を押すと前の画面に戻る
              Navigator.pop(context);
            },
              child: Text(
                "OK",
                style: TextStyle(
                  color: Colors.blue
                ),
              )
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final isar=ref.read(isarProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("ジャンル設定"),
      ),
      body: ListView(
        children: [
          Center(
            child: ListTile(
              leading: Icon(Icons.add),
              title: Text(
                "ジャンルを登録する",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
              onTap: (){
                addGenre();
              },
              minTileHeight: 50,
            ),
          ),

          Divider(),

          Center(
            child: ListTile(
              leading: Icon(Icons.storage),
              title: Text(
                "ジャンル一覧を表示する",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
              onTap: (){ //ボタンが押されたら登録されているジャンル一覧を表示する
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewGenre(isar: isar)
                  )
                );
              },
              minTileHeight: 50,
            ),
          ),

          Divider(),
        ],
      ),
    );
  }
}


//登録されているジャンルを一覧で表示するページのクラス
class ViewGenre extends StatefulWidget {
  //Isarを入れる変数を用意
  final Isar isar;
  //コンストラクタを設定
  ViewGenre({super.key,required this.isar});

  @override
  State<ViewGenre> createState() => _ViewGenreState();
}

class _ViewGenreState extends State<ViewGenre> {
  //編集中かを判定するflagを用意
  bool Editting = false;

  //ジャンルのリストを保持するリストを用意
  List<Genre> _genres = [];

  //削除するときに，本当に消していいか確認するアラートを表示する関数を定義
  void delete_config_alert(String Genre_name,int delte_index){
    showDialog(
      context: context,
      builder: (_){
        return AlertDialog(
          title: Text("確認"),
          content: Text(
            "$Genre_nameを削除します\nよろしいですか？",
            style: TextStyle(
              fontSize: 16
            ),
          ),
          actions: [
            TextButton(onPressed: (){ //「キャンセル」を押すと前の画面に戻る
              Navigator.pop(context);
            },
              child: Text(
                "キャンセル",
                style: TextStyle(
                  color: Colors.blue,
                ),
              )
            ),
            TextButton(onPressed: () async { //「OK」を押すと消す（削除は時間がかかるのでasyncを付ける）----------------------------------------
              Navigator.pop(context);
              await delete_genre(delte_index); //データを消す関数を呼ぶ（時間がかかる処理なので，awaitを付ける）
              _refreshGenres();; //画面をリフレッシュする
            },
              child: Text(
                "OK",
                style: TextStyle(
                  color: Colors.blue,
                ),
              )
            )
          ],
        );
      }
    );
  }

  //データベースからジャンルを削除する関数を宣言
  Future<void> delete_genre(int index) async{
    //削除するデータを変数に保持
    final deleted_genre=_genres[index];
    //削除に成功したときにメッセージを表示する用の変数を宣言
    String deleted_genre_name=deleted_genre.name;
    //削除するデータのidを取得
    int deleted_id=deleted_genre.id;

    try{
      //トランザクションモードに入る
      await widget.isar.writeTxn(() async{
        //successには削除が成功したかが入る
        final success = await widget.isar.genres.delete(deleted_id);
      });

      //削除に成功したメッセージを表示 
      ScaffoldMessenger.of(context).showSnackBar( //スナックバーにメッセージを表示
        SnackBar(
          content: Text("ジャンル「$deleted_genre_name」を削除しました")
        )
      );
    } catch(e){
      //print("削除中にエラーが発生しました");
    }
  }


  //編集モードのときに，ListTileがタップされたら，編集できるようにダイアログを表示する関数を宣言
  void edit_genre(int index){
    //ダイアログ表示用の変数を用意
    //現在のデータ
    final existingGenre=_genres[index];
    //変更前の名前
    String beforeName=existingGenre.name;
    //変更後の名前
    String afterName="";

    _editGenreController.text=_genres[index].name;
    showDialog(
      context: context,
      builder:(context){
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            height: 250,
            child: Column(
              children: [
                SizedBox(height: 20,),

                Center(child: Text( //ダイアログの一番上に出すタイトル
                  "ジャンル名を入力してください",
                  style: TextStyle(
                    fontSize: 20
                  ),
                  ),
                ),

                SizedBox(height: 40,),

                SizedBox( //ジャンル名入力欄
                  width: MediaQuery.of(context).size.width*0.6,
                  //height: ,
                  child: TextField(
                    controller: _editGenreController,
                    //autofocus: true, なぜか動かないのでコメントアウトしておく
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "ジャンル名を入力"
                    ),
                  ),
                ),

                SizedBox(height: 30,),

                SizedBox( //保存ボタン
                  width: MediaQuery.of(context).size.width*0.55,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      if(_editGenreController.text.trim().isEmpty){ //テキストフィールドが空なら
                        return;
                      }

                      try{
                        //書き込みのトランザクションを開始
                        await widget.isar.writeTxn(() async{
                          //データベースから今のデータを取り出す
                          if(existingGenre!=null){
                            //データの名前をテキストフィールドに入力されているものに書き換える
                            afterName=_editGenreController.text.trim();
                            existingGenre.name=afterName;
                            //データベースに上書きする
                            await widget.isar.genres.put(existingGenre);
                          } 
                        });
                        await _refreshGenres(); //画面を更新
                        Navigator.pop(context); //画面を戻す
                        ScaffoldMessenger.of(context).showSnackBar( //スナックバーにメッセージを表示
                          SnackBar(
                            content: Text("「$beforeName」を「$afterName」に変更しました")
                          )
                        );
                      } catch(e){
                        //print("更新中にエラーが発生しました");
                      }
                    },
                    child: Text(
                      "保存",
                      style: TextStyle(
                        fontSize: 13
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  void initState() {
    //親に準備を促す
    super.initState();
    //画面が表示されたら一度だけデータを読み込む
    _refreshGenres();
  }

  //データを読み込む関数
  Future<void> _refreshGenres() async{
    //ジャンルを一覧で表示する
    final allGenres = await widget.isar.genres.where().findAll();

    setState(() {
      _genres=allGenres;
    });
  }

  //ジャンル編集画面に遷移した際に自動でテキストフィールドを埋めるコントローラを宣言
  final TextEditingController _editGenreController = TextEditingController();

  //メモリ解放
  @override
  void dispose(){
    _editGenreController.dispose();
    super.dispose();
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登録されているジャンル"),
        actions: [
          IconButton( //編集，完了切替ボタン
            onPressed: (){
              setState(() {
                if(Editting==true){Editting=false;}
                else{Editting=true;}
              });
            },
            icon: Editting
            ? Icon(Icons.done)
            : Icon(Icons.create)
          ),
          
          SizedBox(width: 10,)
        ],
      ),
      body: _genres.isEmpty
        ? Center(
          child: Text(
            "ジャンルが登録されていません",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey
            ),
          ),
        )
        : ListView(
          children: ListTile.divideTiles( //既にあるリストに仕切り線を入れていくイメージ
            context: context,
            tiles: List.generate(
              _genres.length,
              (index){
                return ListTile( //登録されているジャンル一覧が表示される
                    title: Text(_genres[index].name), //編集中なら並び替えボタンが表示される
                    leading: Editting? IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.menu)
                    ): null, 
                    trailing: Editting? IconButton( //編集中なら削除ボタンが表示される
                      onPressed: (){
                        delete_config_alert(_genres[index].name,index);
                      },
                      icon: Icon(Icons.delete),
                      color: Colors.red[300],
                    ): null,
                    onTap: (){ //編集中にタップするとジャンルを編集できる
                      if(Editting==true){
                        edit_genre(index);
                      }
                    },
                );
              }
              )
            ).toList(),
      ),
      //登録ボタン
      floatingActionButton: Editting
      ? null
      : FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GenreRegistar(initialNewAdd: true)
            )
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}