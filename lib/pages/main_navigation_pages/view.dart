import 'package:flutter/material.dart';

//登録ページ
import 'registar.dart';

//一覧ページ
class ViewPage extends StatefulWidget {
  //コンストラクタを設定
  const ViewPage({super.key});

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage>{
  //登録ページに遷移する関数
  void goToRegistarPage(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context)=> RegistarPage(),
        fullscreenDialog: true
      )
    );
  }

  @override
  Widget build(BuildContext content){
    return Scaffold(
      appBar: AppBar(
        title: Text("一覧"),
        backgroundColor: Colors.lightBlue[100],
        actions: [
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
      floatingActionButton: FloatingActionButton(
        onPressed: goToRegistarPage,
        child: Icon(Icons.add),
      ),
    ); 
  }
}