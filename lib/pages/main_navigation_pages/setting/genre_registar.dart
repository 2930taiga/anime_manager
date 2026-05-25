import 'package:flutter/material.dart';

class GenreRegistar extends StatefulWidget {
  //ジャンルを新しく登録するかどうか
  final bool initialNewAdd ;

  const GenreRegistar({super.key,required this.initialNewAdd});

  @override
  State<GenreRegistar> createState() => _GenreRegistarState();
}

class _GenreRegistarState extends State<GenreRegistar> {
  //初期化でコピーする
  late bool newAdd;

  @override
  void initState(){
    super.initState();
    newAdd = widget.initialNewAdd;
  }

  //RGBの値
  double redValue=0;
  double greenValue=0;
  double blueValue=0;

  //テキストフィールドのコントローラ
  TextEditingController _redController = TextEditingController();
  TextEditingController _greenController = TextEditingController();
  TextEditingController _blueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ジャンル登録"),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: AlignmentGeometry.topCenter,
          child: Column(
            children: [

              SizedBox(height: 20,),

              SizedBox( //--------------------------------------------------------ジャンル名入力欄
                width: MediaQuery.of(context).size.width*0.9,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text){
                    if(text==null || text ==""){
                      return "ジャンル名を入力してください";
                    }
                    else{return null;}
                  },
                  onChanged: (text){

                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "ジャンル名",
                  ),
                ),
              ),

              SizedBox(height: 20,),

              SizedBox( //色入力欄
                width: MediaQuery.of(context).size.width*0.9,
                child: Column(
                  children: [
                    Row( //-------Red
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                                  SizedBox(
                                    child: Text(
                                      "Red",
                                      style: TextStyle(
                                        fontSize: 20
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox()
                                  )
                                ],
                              ),
                              SizedBox(
                                child: Stack(
                                  alignment: AlignmentGeometry.center,
                                  children: [
                                    Container(
                                      height: 6,
                                      width: MediaQuery.of(context).size.width*0.65,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black,
                                            Color.fromARGB(255, 255, 0, 0)
                                          ]
                                        )
                                      ),
                                    ),
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        thumbColor: Colors.white,
                                        trackHeight: 0,
                                        thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 12
                                        )
                                      ),
                                      child: Slider(
                                        min: 0,
                                        max: 255,
                                        value: redValue,
                                        onChanged: (index){
                                          //スライダーが触られたらフォーカスを外す
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          //テキストフィールドの値を更新
                                          _redController.text=index.toInt().toString();
                                          setState(() {
                                            //数値を更新
                                            redValue=index;
                                          });
                                        }
                                      )
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _redController,
                            style: TextStyle(
                            ),
                            decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                            ),
                          )
                        )
                      ],
                    ),

                    Row( //-------Green
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                                  SizedBox(
                                    child: Text(
                                      "Green",
                                      style: TextStyle(
                                        fontSize: 20
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox()
                                  )
                                ],
                              ),
                              SizedBox(
                                child: Stack(
                                  alignment: AlignmentGeometry.center,
                                  children: [
                                    Container(
                                      height: 6,
                                      width: MediaQuery.of(context).size.width*0.65,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black,
                                            Color.fromARGB(255, 0, 255, 0)
                                          ]
                                        )
                                      ),
                                    ),
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        thumbColor: Colors.white,
                                        trackHeight: 0,
                                        thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 12
                                        )
                                      ),
                                      child: Slider(
                                        min: 0,
                                        max: 255,
                                        value: greenValue,
                                        onChanged: (index){
                                          //スライダーが触られたらフォーカスを外す
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          //テキストフィールドの値を更新
                                          _greenController.text=index.toInt().toString();
                                          setState(() {
                                            //数値を更新
                                            greenValue=index;
                                          });
                                        }
                                      )
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _greenController,
                            //initialValue: "0",
                            style: TextStyle(
                            ),
                            decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                            ),
                          )
                        )
                      ],
                    ),

                    Row( //-------Blue
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                                  SizedBox(
                                    child: Text(
                                      "Blue",
                                      style: TextStyle(
                                        fontSize: 20
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox()
                                  )
                                ],
                              ),
                              SizedBox(
                                child: Stack(
                                  alignment: AlignmentGeometry.center,
                                  children: [
                                    Container(
                                      height: 6,
                                      width: MediaQuery.of(context).size.width*0.65,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black,
                                            Color.fromARGB(255, 0, 0, 255)
                                          ]
                                        )
                                      ),
                                    ),
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        thumbColor: Colors.white,
                                        trackHeight: 0,
                                        thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 12
                                        )
                                      ),
                                      child: Slider(
                                        min: 0,
                                        max: 255,
                                        value: blueValue,
                                        onChanged: (index){
                                          //スライダーが触られたらフォーカスを外す
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          //テキストフィールドの値を更新
                                          _blueController.text=index.toInt().toString();
                                          setState(() {
                                            //数値を更新
                                            blueValue=index;
                                          });
                                        }
                                      )
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _blueController,
                            style: TextStyle(
                            ),
                            decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                            ),
                          )
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}