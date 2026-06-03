import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:anime_administration/models/genre.dart';
import 'package:anime_administration/pages/main_navigation_pages/setting/genre/genre_registar.dart';
import 'package:anime_administration/parameter_settings.dart';

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
  void delete_config_alert(String Genre_name,int delete_index){
    showDialog(context: context,
      builder: (_){
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            height: 205,
            child: Column(
              children: [
                SizedBox(height: 20,),

                Text( //タイトル
                  "確認",
                  style: TextStyle(
                    fontSize: 27,
                    color: Texts.errorMessageColor,
                    fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(height: 20,),

                Text( //サブメッセージ
                  "「$Genre_name」を削除しますか？",
                  style: TextStyle(
                    color: Texts.subMessageColor,
                    fontSize: 17
                  ),
                ),

                SizedBox(height: 30,),

                Row( //OK．キャンセルボタン
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.30,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ElevatedButtons.cancelButtonBackgroundColor,
                          padding: EdgeInsets.symmetric(horizontal: 2) //余白を小さくする
                        ),
                        child: Text(
                          "キャンセル",
                          style: TextStyle(
                            color: ElevatedButtons.cancelFontColor,
                            fontSize: 15
                          ),
                        )
                      ),
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                    
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.30,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await delete_genre(delete_index); //データを消す関数を呼ぶ（時間がかかる処理なので，awaitを付ける）
                          _refreshGenres(); //画面をリフレッシュする
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
                        )
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
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
      
      showSnackBar(context,"ジャンル「$deleted_genre_name」を削除しました");
    } catch(e){
      //print("削除中にエラーが発生しました");
    }
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
  
  @override
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
        : ListView.builder(
          itemCount: _genres.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 5,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  title: Text(
                    _genres[index].name,
                    style: TextStyle(
                      fontSize: 17
                    ),
                  ),
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                        255,
                        _genres[index].redValue,
                        _genres[index].greenValue,
                        _genres[index].blueValue
                      ).withValues(alpha: 0.08),
                      border: Border.all(
                        color: Color.fromARGB(
                          255,
                          _genres[index].redValue,
                          _genres[index].greenValue,
                          _genres[index].blueValue
                        ).withValues(alpha: 0.15),
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      IconShapeDatas[
                        _genres[index].iconShape.index
                      ],
                      size: 30,
                      color: Color.fromARGB(
                        255,
                        _genres[index].redValue,
                        _genres[index].greenValue,
                        _genres[index].blueValue
                      ),
                    ),
                  ),
                  trailing: Editting? IconButton( //編集中なら削除ボタンが表示される
                    onPressed: (){
                      delete_config_alert(_genres[index].name,index);
                    },
                    icon: Icon(
                      Icons.delete_outlined,
                      size: 28,
                    ),
                    color: Colors.red[300],
                  ): null,
                  onTap: () async { //編集中にタップするとジャンルを編集できる，ここをデータベースから読み込む---------------------------------------------
                    if(Editting==true){
                      //edit_genre(index);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (content) => GenreRegistar(
                            initialNewAdd: false,
                            title: _genres[index].name,
                            rgbColors: [_genres[index].redValue,
                            _genres[index].greenValue,
                            _genres[index].blueValue],
                            id: _genres[index].id,
                            iconData: IconShapeDatas[_genres[index].iconShape.index],
                            iconShape: _genres[index].iconShape,
                          )
                        )
                      );

                      //画面に戻ってきたら画面を更新
                      _refreshGenres();
                    }
                  }
                ),
              ),
            );
          },
      ),
      //登録ボタン
      floatingActionButton: Editting
      ? null
      : FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GenreRegistar(initialNewAdd: true,title: "",rgbColors: [0,0,0],id: 0,iconData: Icons.circle,iconShape: IconShape.circle,)
            )
          );
            
          //画面に戻ってきたら画面を更新
          _refreshGenres();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}