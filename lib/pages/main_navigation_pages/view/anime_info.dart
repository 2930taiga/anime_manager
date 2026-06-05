import 'package:anime_administration/models/anime.dart';
import 'package:anime_administration/parameter_settings.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

//アニメ情報を表示する画面
class AnimeInfo extends StatefulWidget {
  final Anime anime;
  const AnimeInfo({
    super.key,
    required this.anime
  });

  @override
  State<AnimeInfo> createState() => _AnimeInfoState();
}

class _AnimeInfoState extends State<AnimeInfo> {
  //paddingのパラメータ
  double cardPaddingHorizontal = 5;
  double cardPaddingVertical = 5;
  double containerPaddingHorizontal = 5;
  double containerPaddingVertical = 5;

  //詳細情報を表示するかどうか
  bool detailInfo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton( //戻るボタン
          onPressed:(){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back)
        ),

        title: Text(widget.anime.title), //タイトル

        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.more_vert_outlined)
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Expanded(
            child: Scrollbar(
              child: ListView(
                children: [
                  Padding( //タイトルその他
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: cardPaddingHorizontal,
                      vertical: cardPaddingVertical
                    ),
                    child: Container(
                      width: double.infinity,
                      //height: 500,
                      padding: EdgeInsets.symmetric(
                        horizontal: containerPaddingHorizontal,
                        vertical: containerPaddingVertical
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text( //タイトル
                                      widget.anime.title,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    if(detailInfo==true)
                                    Text(
                                      widget.anime.titleKana,
                                      style: TextStyle(
                                        fontSize: 15
                                      ),
                                    )
                                  ],
                                )
                              ),
                              IconButton( //詳細表示/非表示ボタン
                                onPressed: (){
                                  setState(() {
                                    if(detailInfo==true){
                                      detailInfo=false;
                                    }
                                    else{
                                      detailInfo=true;
                                    }
                                  });
                                },
                                icon: detailInfo
                                ? Icon(Icons.expand_less)
                                : Icon(Icons.expand_more)
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding( //タイトルその他
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: cardPaddingHorizontal,
                      vertical: cardPaddingVertical
                    ),
                    child: Container(
                      width: double.infinity,
                      //height: 500,
                      padding: EdgeInsets.symmetric(
                        horizontal: containerPaddingHorizontal,
                        vertical: containerPaddingVertical
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          Text(
                            "data",
                            style: TextStyle(
                              fontSize: 20
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            )
          ),
          
        ],
      ),
    );
  }
}