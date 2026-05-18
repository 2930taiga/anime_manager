import 'package:flutter/material.dart';

//ページ関連-------------------------------------------------------------
//登録ページ
import 'main_navigation_pages/registar.dart';
//一覧ページ
import 'main_navigation_pages/view.dart';
//分析ページ
import 'main_navigation_pages/analysys.dart';
//カレンダーページ
import 'main_navigation_pages/calendar.dart';
//設定ページ
import 'main_navigation_pages/setting.dart';

class MainNavigation extends StatefulWidget {

  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  //ページ番号
  int pageNum = 0;

  //アプリ起動時にisarの準備が出来ていないので，初めは空にしておき，初期化イベントの中でリストを作成する
  late List<Widget> navigationPageList=[];
  
  //描画が始まる前にリストを作成する
  @override
  void initState(){
    super.initState();
    navigationPageList=[
      ViewPage(),
      AnalysisPage(),
      CalendarPage(),
      SettingPage()
    ];
  }

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
  Widget build(BuildContext context) {
    return PopScope(
      canPop: pageNum==0, //一覧ページにいるなら「戻る」を有効にする
      onPopInvokedWithResult: (didpop,result){
        if(didpop==true){ //「戻る」が正常に行われていれば何もしない
          return;
        }

        if(pageNum!=0){
          setState(() {
            pageNum=0;
          });
        }

      },
      child: Scaffold(
        //登録中なら登録ページ，そうでないならナビゲーションのリスト
        body: navigationPageList[pageNum],

        floatingActionButton: pageNum==0? FloatingActionButton(
          onPressed: goToRegistarPage,
          child: const Icon(Icons.add),
        ):null, 

        bottomNavigationBar:BottomNavigationBar(
          currentIndex: pageNum,
          items: const[ //ページ一覧
            BottomNavigationBarItem(icon: Icon(Icons.notes),label: "一覧"), //一覧
            BottomNavigationBarItem(icon: Icon(Icons.pie_chart),label: "分析"), //分析
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month),label: "カレンダー"), //カレンダー
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: "設定") //設定
          ],
          onTap: (index){
            setState(() {  
              pageNum=index;
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