import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

//登録ページ
import 'pages/registar.dart';
//一覧ページ
import 'pages/view.dart';
//分析ページ
import 'pages/analysys.dart';
//カレンダーページ
import 'pages/calendar.dart';
//設定ページ
import 'pages/setting.dart';

//データベースの構造モデルのスクリプト
import 'models/anime.dart';
import 'models/genre.dart';

void main() async { //メイン関数
  //--------データベースを扱うための前準備を書く-----------------
  //flutterが起動する前（画面を用意する前）にシステムを起動する
  WidgetsFlutterBinding.ensureInitialized();
  //データの保存場所を決定する
  final dir = await getApplicationDocumentsDirectory();
  //データベースを起動する
  final isar = await Isar.open(
    [GenreSchema,AnimeSchema], //これは.g.dartの中で指定されている
    directory:dir.path
  );

  //MyAppにisarを渡す
  runApp(MyApp(isar: isar));
}

class MyApp extends StatelessWidget {
  //isarを入れるための変数を用意する
  final Isar isar;

  const MyApp({super.key,required this.isar});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      home: MyHomePage(title: 'hogehoge',isar: isar),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.isar});
  final Isar isar;

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //ページ番号
  int page_num=0;

  //ページのリスト
  //アプリ起動時にisarの準備が出来ていないので，初めは空にしておき，初期化イベントの中でリストを作成する
  late List<Widget> navigation_page_list=[];

  //登録ページに遷移する関数
  void goToRegistarPage(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context)=> RegistarPage(back: pop_back,isar: widget.isar,),
        fullscreenDialog: true
      )
    );
  }

  //戻る関数（pop）
  void pop_back(){
    Navigator.of(context).pop();
  }

  //タイトルのリスト
  final List<String> title_list=[
    "一覧","分析","カレンダー","設定"
  ];

  @override
  void initState(){
    super.initState();
    navigation_page_list=[
      ViewPage(isar: widget.isar),
      AnalysisPage(),
      CalendarPage(),
      SettingPage(isar: widget.isar)
    ];
  }

  Widget build(BuildContext context) {
    return PopScope(
      canPop: page_num==0, //一覧ページにいるなら「戻る」を有効にする
      onPopInvokedWithResult: (didpop,result){
        if(didpop==true){ //「戻る」が正常に行われていれば何もしない
          return;
        }

        if(page_num!=0){
          setState(() {
            page_num=0;
          });
        }

      },
      child: Scaffold(
        //登録中なら登録ページ，そうでないならナビゲーションのリスト
        body: navigation_page_list[page_num],

        floatingActionButton: page_num==0? FloatingActionButton(
          onPressed: goToRegistarPage,
          child: const Icon(Icons.add),
        ):null, 

        bottomNavigationBar:BottomNavigationBar(
          currentIndex: page_num,
          items: const[ //ページ一覧
            BottomNavigationBarItem(icon: Icon(Icons.notes),label: "一覧"), //一覧
            BottomNavigationBarItem(icon: Icon(Icons.pie_chart),label: "分析"), //分析
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month),label: "カレンダー"), //カレンダー
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: "設定") //設定
          ],
          onTap: (index){
            setState(() {  
              page_num=index;
            });
          },

          //選ばれているものは青色に
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,

          //選ばれていないもののラベルも表示する
          type: BottomNavigationBarType.fixed,

          ),
      )
    );
  }
}
