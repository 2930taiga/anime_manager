import 'package:anime_administration/models/anime.dart';
import 'package:flutter/material.dart';
import 'package:anime_administration/parameter_settings.dart';

class AnimeAnalysisTime extends StatefulWidget {
  final List<Anime> anime;
  final int totalTime;
  const AnimeAnalysisTime({super.key, required this.anime,required this.totalTime});

  @override
  State<AnimeAnalysisTime> createState() => _AnimeAnalysisTimeState();
}

class _AnimeAnalysisTimeState extends State<AnimeAnalysisTime> {
  //時間の詳細情報を表示するかどうか
  bool showTimeDetail = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: 10,
        vertical: 5
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10
        ),
        decoration: BoxDecoration(
          color: StatusColors.boxColors[2],
          borderRadius: BorderRadiusDirectional.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 17,
                vertical: 10
              ),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    if(showTimeDetail==true){showTimeDetail=false;}
                    else{showTimeDetail=true;}
                  });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "アニメを見た時間",
                        style: TextStyle(
                          color: StatusColors.textColors[2],
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    ),
                    Icon(
                      showTimeDetail
                      ? Icons.expand_less
                      : Icons.expand_more
                    )
                  ],
                ),
              )
            ),


            //分
            if(showTimeDetail) 
            Padding( 
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 8,
                horizontal: 10
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 7
                ),
                child: Row(
                  children: [
                    Padding( //アイコン
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 10,
                        horizontal: 10
                      ),
                      child: Icon(
                        Icons.access_alarm_sharp,
                        size: 55,
                        color: StatusColors.textColors[2],
                      ),
                    ),

                    Padding( //右側の情報
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 10
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.totalTime.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  horizontal: 10
                                ),
                                child: Text(
                                  "minute",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 116, 116, 116),
                                    fontSize: 17
                                  ),
                                )
                              )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsetsGeometry.only(
                              bottom: 5
                            ),
                            child: Text(
                              "合計視聴時間（分）",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 116, 116, 116),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),


            //時間
            if(showTimeDetail) 
            Padding( 
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 8,
                horizontal: 10
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 7
                ),
                child: Row(
                  children: [
                    Padding( //アイコン
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 10,
                        horizontal: 10
                      ),
                      child: Icon(
                        Icons.hourglass_empty,
                        size: 55,
                        color: StatusColors.textColors[2],
                      ),
                    ),

                    Padding( //右側の情報
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 10
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                (widget.totalTime.toDouble()/60.0).toStringAsFixed(2),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  horizontal: 10
                                ),
                                child: Text(
                                  "hour",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 116, 116, 116),
                                    fontSize: 17
                                  ),
                                )
                              )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsetsGeometry.only(
                              bottom: 5
                            ),
                            child: Text(
                              "合計視聴時間（時間）",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 116, 116, 116),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),


            //日
            if(showTimeDetail)
            Padding( 
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 8,
                horizontal: 10
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 7
                ),
                child: Row(
                  children: [
                    Padding( //アイコン
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 10,
                        horizontal: 10
                      ),
                      child: Icon(
                        Icons.calendar_month_outlined,
                        size: 55,
                        color: StatusColors.textColors[2],
                      ),
                    ),

                    Padding( //右側の情報
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 10
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                (widget.totalTime.toDouble()/1440.0).toStringAsFixed(2),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  horizontal: 10
                                ),
                                child: Text(
                                  "days",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 116, 116, 116),
                                    fontSize: 17
                                  ),
                                )
                              )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsetsGeometry.only(
                              bottom: 5
                            ),
                            child: Text(
                              "合計視聴時間（日）",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 116, 116, 116),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}