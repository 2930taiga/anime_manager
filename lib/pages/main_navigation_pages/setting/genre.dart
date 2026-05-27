import 'package:anime_administration/pages/main_navigation_pages/setting/genre_registar.dart';
import 'package:anime_administration/pages/main_navigation_pages/setting/genre_view.dart';
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context)=> GenreRegistar(initialNewAdd: true,title: "",rgbColors: [0,0,0],id: 0,),
                  )
                );
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
