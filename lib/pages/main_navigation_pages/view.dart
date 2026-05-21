import 'package:flutter/material.dart';

//登録ページ
import 'registar_navigation.dart';

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
        builder: (context)=> RegistarNavigation(),
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
      body: Stack(
        children: [
          Center(
            child: Text(
              "データが登録されていません",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey
              ),
            ),
          ),
          Positioned( //検索窓
          //配置が良い感じになるように
            top: 10,
            left: MediaQuery.of(context).size.width*0.025,
            width: MediaQuery.of(context).size.width*0.95,
            child: SearchBar(
              hintText: "検索",
              leading: const Icon(Icons.search),
            )
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToRegistarPage,
        child: Icon(Icons.add),
      ),
    ); 
  }
}