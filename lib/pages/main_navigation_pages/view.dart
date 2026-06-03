import 'package:anime_administration/models/anime.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
//登録ページ
import 'registar_navigation.dart';
//isarのprovider
import 'package:anime_administration/providers/isar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewPage extends ConsumerStatefulWidget {
  const ViewPage({super.key,});

  @override
  ConsumerState<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends ConsumerState<ViewPage> {
  //アニメのリストを保持する変数
  List<Anime> _animes=[];

  //アニメ一覧を取得する関数
  Future<void> _refreshAnimes() async {
    //アニメを一覧で表示する
    final isar = ref.read(isarProvider);
    final allAnimes = await isar.animes.where().findAll();

    setState(() {
      _animes=allAnimes;
    });
  }

  //画面が表示されたら一度だけ画面をリフレッシュする
  void initState(){
    //親に準備を促す
    super.initState();
    //画面が更新されたらデータを読み込む
    _refreshAnimes();
  }

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
            onPressed: (){
              print(_animes[7].title);
            },
            icon: Icon(Icons.sort)
          ),
          IconButton( //フィルターボタン
            onPressed: (){},
            icon: Icon(Icons.filter_alt)
          )
        ],
      ),
      body: _animes.isEmpty
      ? Center(
        child: Text(
          "データが登録されていません",
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey
          ),
        ),
      )
      : ListView.builder(
        itemCount: _animes.length,
        itemBuilder: (context,index){
          return ListTile(
            leading: IconButton(onPressed: (){}, icon: Icon(Icons.abc)),
            title: Text(_animes[index].title,
            style: TextStyle(
              color: Colors.black
            ),
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToRegistarPage,
        child: Icon(Icons.add),
      ),
    ); 
  }
}

// class ViewPage extends StatefulWidget {
//   //コンストラクタを設定
//   const ViewPage({super.key});

//   @override
//   _ViewPageState createState() => _ViewPageState();
// }

// class _ViewPageState extends State<ViewPage>{
//   //isarのprovider
//   //final isar = 

//   //アニメ一覧を取得する関数
//   Future<void> _refreshAnimes() async {
//     //アニメを一覧で表示する
//     final allAnimes = await null;
//   }


//   //登録ページに遷移する関数
//   void goToRegistarPage(){
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context)=> RegistarNavigation(),
//         fullscreenDialog: true
//       )
//     );
//   }

//   @override
//   Widget build(BuildContext content){
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("一覧"),
//         backgroundColor: Colors.lightBlue[100],
//         actions: [
//           IconButton( //ソートボタン
//             onPressed: (){},
//             icon: Icon(Icons.sort)
//           ),
//           IconButton( //フィルターボタン
//             onPressed: (){},
//             icon: Icon(Icons.filter_alt)
//           )
//         ],
//       ),
//       body: Center(
//         child: Text("ジャンルが登録されていません"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: goToRegistarPage,
//         child: Icon(Icons.add),
//       ),
//     ); 
//   }
// }