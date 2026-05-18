import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

//一覧ページ
class ViewPage extends StatefulWidget {
  //isarを受け取るための変数を作成
  final Isar isar;
  //コンストラクタを設定（isarを必須にする）
  const ViewPage({super.key,required this.isar});

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage>{
  //検索中かどうか
  bool _isSerching = false;

  @override
  Widget build(BuildContext content){
    return PopScope( //戻るボタンで検索モードから抜ける
      canPop: !_isSerching, //検索モードでなければ，通常の「戻る」を有効にする
      onPopInvokedWithResult: (didPop,result){
        //もし「戻る」が既に完了しているなら何もしない
        if(didPop==true){
          return;
        }

        if(_isSerching==true){ //「戻る」がされたときに検索中なら検索欄を閉じる
          setState(() {
            _isSerching=false;
          });
        }
      },
      child : Scaffold(
        appBar: AppBar(
          title: _isSerching? Row(
            children: [
              SizedBox(width: 1,),
              SizedBox(
                width: 230,
                height: 45,
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "検索"
                  ),
                ),
              )
            ],
          ):Text("一覧"),
          backgroundColor: Colors.lightBlue[100],
          actions: [
            IconButton( //検索ボタン
              onPressed: (){
                //検索中のflagを立てて再描画
                setState(() {
                  if(_isSerching==true){_isSerching=false;}
                  else{_isSerching=true;}
                });
              },
              icon: Icon(Icons.search)
            ),
            IconButton( //ソートボタン
              onPressed: (){},
              icon: Icon(Icons.sort)
            ),
            IconButton( //フィルターボタン
              onPressed: (){},
              icon: Icon(Icons.filter_alt)
            )
          ],
        ),
        body: Center(
          child: Text(
            "データが登録されていません",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey
            ),
          ),
        ),
      )
    ); 
  }
}