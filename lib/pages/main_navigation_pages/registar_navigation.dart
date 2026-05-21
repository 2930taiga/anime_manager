import 'package:flutter/material.dart';

//アニメ登録ページ
import 'package:anime_administration/pages/main_navigation_pages/registar/anime_registar.dart';
//映画登録ページ
import 'package:anime_administration/pages/main_navigation_pages/registar/manga_registar.dart';
//漫画登録ページ
import 'package:anime_administration/pages/main_navigation_pages/registar/movie_registar.dart';
//小説登録ページ
import 'package:anime_administration/pages/main_navigation_pages/registar/novel_registar.dart';

class RegistarNavigation extends StatefulWidget {
  const RegistarNavigation({super.key});

  @override
  State<RegistarNavigation> createState() => _RegistarNavigationState();
}

class _RegistarNavigationState extends State<RegistarNavigation> {
  //ページ番号
  int pageNum=0;
  //念のためはじめはページのリストを空にしておき，後からページを追加する
  late List<Widget> registarNavigationPageList=[];
  //ページを追加する
  @override
  void initState(){
    super.initState();
    registarNavigationPageList=[
      AnimeRegistar(),
      MovieRegistar(),
      MangaRegistar(),
      NovelRegistar(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: registarNavigationPageList[pageNum],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageNum,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.monitor),label: "アニメ"),
          BottomNavigationBarItem(icon: Icon(Icons.movie),label: "映画"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book),label: "マンガ"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded),label: "小説"),
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
    );
  }
}