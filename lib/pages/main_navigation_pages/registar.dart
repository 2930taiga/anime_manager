import 'package:anime_administration/providers/isar_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // これがないとWidgetが使えない

//データベースに関するものをインポート
import 'package:anime_administration/models/genre.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

//登録ページ

class RegistarPage extends StatelessWidget {

  const RegistarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController( //地上波か映画を選択できるタブを作成
      length: 2, //2タブ
      child: Scaffold(
        appBar: AppBar(
          title: const Text("登録"),
          leading: IconButton(
            onPressed: (){},
            icon: Icon(Icons.keyboard_backspace)
            ),
            actions: [ //保存ボタンを右上に置いてもいいかなって思った
              TextButton(
                onPressed: (){}, //一旦は戻るだけ
                child: Text(
                  "保存",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15
                  ),
                )
              )
            ],
        ), 
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.monitor),text: "アニメ",),
                Tab(icon: Icon(Icons.movie),text: "劇場版",)
              ],
            ),

            Expanded(
              child: TabBarView(
                children:[
                  TVRegistar(),
                  MovieRegistar()
                ]
              ),
            ),
          ],
        ),
      )
    );
  }
}

class TVRegistar extends ConsumerStatefulWidget {
  const TVRegistar({super.key});

  @override
  ConsumerState<TVRegistar> createState() => _TVRegistarState();
}

class _TVRegistarState extends ConsumerState<TVRegistar> {
  final int? _selectedValue = 0; //プルダウンを動かせるようにするための仮の変数
  final DateTime _selectedDate = DateTime.now(); //カレンダーに登録する日付

  final String _epNum_st = "話数選択"; //話数（ボタンに表示する用）
  int? _epNum ; //話数（整数型で保持する用）

  final String _epTime_st = "1話あたり時間選択"; //分数（ボタンに表示する用）
  int? _epTime ; //分数（整数型で保持する用）

  int _evaluation = 0; //評価（5段階）

  final TextEditingController _dateController = TextEditingController(); //日付を自動で入力するコントローラーを登録
  final TextEditingController _epNumController = TextEditingController(); //話数を自動で入力するコントローラーを登録
  final TextEditingController _epTimeController = TextEditingController(); //分数を自動で入力するコントローラーを登録

  //登録画面で内容を保持する変数を宣言しておく-----------------------------------------------------------------------------------

  //ピッカーで選ばれているものを保持する変数を宣言しておく------------------------------------------------------------------------
  int _pickerSelected_EpNum=0;
  int _pickerSelected_Hour=0;
  int _pickerSelected_Min=0;

  //SnackBarで表示するテキストのインスタンスを登録しておく------------------------------------------------------------------------
  var SnackBar_Save = SnackBar(content: Text("保存しました"));

  //選択されているジャンルを表示するTextFieldの文字列を格納しておく変数を宣言------------------------------------------------------
  String select_genre_text="ジャンルが選択されていません";

  //ジャンル選択で必要となる変数を宣言しておく------------------------------------------------------------------------------------
  // //ジャンルのデータを保持するリストを宣言
  List<Genre> _genres=[];
  // //選択されているジャンルのidを保持しておく変数を宣言
  Set<int> selected_genre_id={};

  //ウィジェット立ち上げ時にデータベースからジャンルのデータを読み取る関数を宣言
  Future<void> load_db() async {
    final Isar isar=ref.read(isarProvider);
    //データベースからデータを取り出す
    _genres = await isar.genres.where().findAll();
  }

  @override
  void initState(){
    super.initState(); //おまじない
    //データベース関連の処理の関数を実行
    load_db();
  }

  //ボタンを押すと今日の日付を自動で入力する関数を宣言
  void _setTodayDate(){
    //今日の日付を取得
    DateTime date = DateTime.now();
    //日付の見た目をフォーマット
    String FormattedDate = "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";

    //コントローラのテキストを書き換えると，TextFieldの中身も書き換わる
    setState(() {
      _dateController.text=FormattedDate;
    });
  }

  //ボタンを押すとカレンダーが起動し，日付を選択できるようになる関数を宣言
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker( //カレンダーを表示して，日付選択画面を出す
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2100)
      );

      //入力された日付を変数に代入
      if (picked != null){
        //入力された日付を代入
        DateTime date= picked;
        //日付の見た目をフォーマット
        String FormattedDate = "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";

        //コントローラのテキストを書き換えて，TextFieldの中身を書き換える
        setState(() {
          _dateController.text=FormattedDate;
        });
      }
  }

  //ボタンを押すと，任意の話数を自動で入力する関数を宣言
  void _setEpNum(int epNum){
    FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
    setState(() {
      _epNumController.text=epNum.toString(); //話数を自動で入力する
    }); 
  }

  //ボタンを押すと，任意の分数を自動で入力する関数を宣言
  void _setEpTime(int epTime){
    FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
    setState(() {
      _epTimeController.text="0:"+epTime.toString(); //話数を自動で入力する
    }); 
  }

  //任意の時間（時:分）を自動で入力する関数を宣言
  void _setEpTime1(int epHour, int epMin){
    setState(() {
      _epTimeController.text="${epHour}:${epMin.toString().padLeft(2,"0")}"; //話数を自動で入力する
    }); 
  }

  //ボタンを押すと，話数選択のスロットを表示する関数を宣言
  Future<void> _selectEpNum(BuildContext context) async{
    showModalBottomSheet(
      context: context, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(0) //下から出てくるやつの角を四角くする
      ),
      builder: (context){
        return Container(
          width: MediaQuery.of(context).size.width*1.0,
          height: 250,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(0)
          // ),
          child: Column(
            children: [
              SizedBox( //上部に出す「キャンセル」，「タイトル」，「決定」のボタン
                height: 50,
                width: MediaQuery.of(context).size.width*1.0,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.23,
                          child: Center(
                            child: TextButton( //話数選択画面のキャンセルボタン
                              onPressed:(){
                                Navigator.of(context).pop(); //画面を戻る
                                FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
                              },
                              child: Text(
                                "キャンセル",
                                style: TextStyle(
                                  color: Colors.blue
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.57,
                          child: Center(
                            child: Text( //話数選択画面の上部のテキスト
                              "話数選択",
                              style: TextStyle(
                                fontSize: 20
                              ),
                              ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.2,
                          child: Center(
                            child: TextButton( //話数選択画面の保存ボタン
                              onPressed: (){
                                //ScaffoldMessenger.of(context).showSnackBar(SnackBar_Save);
                                _setEpNum(_pickerSelected_EpNum); //テキストフィールドの話数を更新
                                Navigator.pop(context); //前の画面に戻る
                                FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
                              },
                              child: Text(
                                "保存",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 110,
                width: MediaQuery.of(context).size.width*0.7,
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (index){
                    _pickerSelected_EpNum=index;
                  },
                  children: List.generate(100,(index){
                    return Center(
                      child: Text(
                        "${index}"
                      ),
                    );
                  })
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  //ボタンを押すと，時間選択のスロットを表示する関数を宣言
  Future<void> _selectEpTime(BuildContext context) async{
    showModalBottomSheet(
      context: context, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(0) //下から出てくるやつの角を四角くする
      ),
      builder: (context){
        return Container(
          width: MediaQuery.of(context).size.width*1.0,
          height: 250,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(0)
          // ),
          child: Column(
            children: [
              SizedBox( //上部に出す「キャンセル」，「タイトル」，「決定」のボタン
                height: 50,
                width: MediaQuery.of(context).size.width*1.0,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.23,
                          child: Center(
                            child: TextButton( //時間選択画面のキャンセルボタン部分
                              onPressed:(){
                                Navigator.of(context).pop(); //画面を戻る
                                FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
                              },
                              child: Text(
                                "キャンセル",
                                style: TextStyle(
                                  color: Colors.blue
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.57,
                          child: Center(
                            child: Text( //時間選択画面上部のテキスト部分
                              "時間選択",
                              style: TextStyle(
                                fontSize: 20
                              ),
                              ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.2,
                          child: Center(
                            child: TextButton( //時間選択画面の保存ボタン部分
                              onPressed: (){
                                //ScaffoldMessenger.of(context).showSnackBar(SnackBar_Save);
                                //保存ボタンが押されたら，TextFieldに数値を入力して閉じる
                                _setEpTime1(_pickerSelected_Hour, _pickerSelected_Min);
                                Navigator.pop(context); //画面を戻る
                                FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
                              },
                              child: Text(
                                "保存",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 110,
                width: MediaQuery.of(context).size.width*0.7,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.3,
                      child: CupertinoPicker( //時間選択の「時間」部分
                        itemExtent: 40,
                        onSelectedItemChanged: (index){
                          //時間が選ばれるたびに変数を更新する
                          _pickerSelected_Hour=index;
                        },
                        children: List.generate(100,(index){
                          return Center(
                            child: Text(
                              "${index}"
                            ),
                          );
                        })
                      ),
                    ),
                    SizedBox(
                      width:  MediaQuery.of(context).size.width*0.1,
                      child: Center(
                        child: Text(
                          ":",
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.3,
                      child: CupertinoPicker( //時間選択の「分数」部分
                        itemExtent: 40,
                        onSelectedItemChanged: (index){
                          //分数が選ばれるたびに変数を更新する
                          _pickerSelected_Min=index;
                        },
                        children: List.generate(60,(index){
                          return Center(
                            child: Text(
                              "${index}"
                            ),
                          );
                        })
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  //-------------------------------------------------------------ボタンを押すと，ジャンル選択画面を表示する関数を宣言
  Future<void> select_genre (Isar isar) async {
    //ボタンの初期状態を読み取る
    //for文が何回回ったかカウントする変数を用意
    int i =0;
    //まずは中身が全てfalseのリストを用意
    List<bool> genre_select_state = List.filled(_genres.length, false);
    //selected_genre_idにそのidが含まれていたらfalse→trueに書き換える
    for (Genre genre_instance in _genres){
      //ジャンルのインスタンスのidが選ばれているジャンルのidを保持するリストに含まれているかを確認
      if(selected_genre_id.contains(genre_instance.id)){
        genre_select_state[i]=true;
      }
      //周回をカウント
      i=i+1;
    }

    showDialog(
      context: context,
      builder: (context){
        return StatefulBuilder(
          builder: (context,setStateDialog){
            return Dialog(
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.9,
                height: 400,
                child: Column(
                  children: [

                    SizedBox(height: 20,),

                    Text(
                      "ジャンルを選択してください",
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),

                    SizedBox(height: 10,),

                    Expanded(
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: ListView(
                          children: List.generate(
                            _genres.length,
                            (index){
                              return SwitchListTile( //スイッチタイル部分
                                title: Text(_genres[index].name),
                                value: genre_select_state[index],
                                onChanged: (bool value){ //あるジャンルが選択されたときの処理
                                  setStateDialog((){
                                    //off→onになったとき
                                    if(value==true){
                                      //選択されているジャンルのidを保持しておくSet内にidを追加
                                      selected_genre_id.add(_genres[index].id);
                                    }
                                    //on→offになったとき
                                    else{
                                      selected_genre_id.remove(_genres[index].id);
                                    }
                                    //ダイアログを呼び出したときに仮で作成したboolのリストの中身を書き換える
                                    genre_select_state[index]=value;
                                  });
                                },
                              );
                            }
                          ),
                        )
                      )
                    ),

                    SizedBox(height: 10,),

                    SizedBox( //保存ボタン
                      width: MediaQuery.of(context).size.width*0.4,
                      child: ElevatedButton(
                        onPressed: (){
                          //ジャンル表示テキストに表示する用のテキストを作成
                          //初期文字列
                          String genre_text_temp="";
                          for(int _id in selected_genre_id){
                            //選択されているジャンルのidから，文字列を作成
                            genre_text_temp += _genres.firstWhere((g) => g.id == _id).name; //データベースのデータをコピーしたリストからidが一致するものを探し出し，nameを取得する
                            //","で区切る
                            genre_text_temp += "，";
                          }

                          //最後の","を取る
                          if(genre_text_temp!=""){
                            genre_text_temp = genre_text_temp.substring(0 , genre_text_temp.length - 1 );
                          }

                          //もし文字列が空白のままなら，「ジャンルが選択されていません」に戻す
                          if(genre_text_temp == ""){
                            genre_text_temp = "ジャンルが選択されていません";
                          }

                          //選択されているジャンルを表示するTextの中身を書き換える
                          setState(() {
                            select_genre_text=genre_text_temp;
                          });
                          
                          //戻る
                          Navigator.pop(context);
                          //テキストのフォーカスを外す
                          FocusScope.of(context).unfocus();
                        },
                        child: Text("保存")
                      ),
                    ),

                    SizedBox(height: 20,)
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }

  @override //メモリ開放処理
  void dispose(){
    _dateController.dispose();
    _epTimeController.dispose();
    _epNumController.dispose();
    super.dispose(); //おまじない
  }

  //----------------------------------------------------ここから登録のメイン画面
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // キーボード対策にこれを入れておくと安心
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const SizedBox(height: 20),

              SizedBox( //-------------------------------------------------ステータス（プルダウン）
                width: MediaQuery.of(context).size.width * 0.9,
                child: DropdownMenu(
                  label: Text("ステータス"),
                  dropdownMenuEntries: const[
                    DropdownMenuEntry(value: 0, label: "未視聴"),
                    DropdownMenuEntry(value: 1, label: "視聴中"),
                    DropdownMenuEntry(value: 2, label: "視聴済"),
                    DropdownMenuEntry(value: 3, label: "視聴中止"),
                    DropdownMenuEntry(value: 4, label: "中断"),
                  ]
                  ),
              ),

              const SizedBox(height: 20),

              SizedBox( //-------------------------------------------------タイトル（文字入力欄）
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "タイトル",
                  ),
                ),
              ),
              
              const SizedBox(height: 20),

              SizedBox( //-------------------------------------------------タイトルかな（文字入力欄）
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "タイトル（かな）",
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox( //-------------------------------------------------日付表示（文字入力欄）
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                child: TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "日付",
                  ),
                ),
              ),

              SizedBox( //-------------------------------------------------日付入力ボタン（カレンダー）
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.44,
                      child: ElevatedButton(
                        onPressed: _setTodayDate, 
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                        ),
                        child: Text("今日の日付")
                        )
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02), //ボタン同士がぴったりくっついてるとダサいので，間隔を開ける
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.44,
                      child: ElevatedButton(
                        onPressed: (){
                          _selectDate(context);
                        }, 
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                        ),
                        child: Text("日付選択")
                        )
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container( //------------------------------------------------ジャンル選択欄（選択済みジャンル表示欄）
                height: 55,
                width: MediaQuery.of(context).size.width*0.9,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(7)
                ),
                child: Center(
                  child: Text(
                    select_genre_text,

                    style: TextStyle(
                      fontSize: 17
                    ),
                  ),
                )
                
              ),

              SizedBox(height: 8,),

              SizedBox(
                width: MediaQuery.of(context).size.width*0.9,
                child: ElevatedButton(
                  onPressed: (){
                    final Isar isar = ref.read(isarProvider);                
                    select_genre(isar);
                  },
                  child: Text(
                    "ジャンル選択"
                  )
                ),
              ),

              const SizedBox(height: 20,),

              SizedBox( //-------------------------------------------------話数（文字入力欄）
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                child: TextField(
                  controller: _epNumController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "話数",
                  ),
                ),
              ),

              SizedBox( //-------------------------------------------------話数入力ボタン（ボタン）
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2866666,
                      child: ElevatedButton(
                        onPressed: (){
                          _setEpNum(12);
                        }, 
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                        ),
                        child: Text("12話")
                        )
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width * 0.02), //ボタン同士がぴったりくっついてるとダサいので，間隔を開ける

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2866666,
                      child: ElevatedButton(
                        onPressed: (){
                          _setEpNum(24);
                        }, 
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                        ),
                        child: Text("24話")
                        )
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width * 0.02), //ボタン同士がぴったりくっついてるとダサいので，間隔を開ける

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2866666,
                      child: ElevatedButton(
                        onPressed: (){
                          _selectEpNum(context);
                        }, 
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                        ),
                        child: Text("話数選択")
                        )
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),

              SizedBox( //-------------------------------------------------分数（文字入力欄）
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                child: TextField(
                  controller: _epTimeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "1話あたりの時間",
                  ),
                ),
              ),

              SizedBox( //-------------------------------------------------分数入力ボタン（ボタン）
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2866666,
                      child: ElevatedButton(
                        onPressed: (){
                          _setEpTime(24);
                        }, 
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                        ),
                        child: Text("24分")
                        )
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width * 0.02), //ボタン同士がぴったりくっついてるとダサいので，間隔を開ける

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2866666,
                      child: ElevatedButton(
                        onPressed: (){
                          _setEpTime(12);
                        }, 
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                        ),
                        child: Text("12分")
                        )
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width * 0.02), //ボタン同士がぴったりくっついてるとダサいので，間隔を開ける

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2866666,
                      child: ElevatedButton(
                        onPressed: (){
                          _selectEpTime(context);
                        }, 
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                        ),
                        child: Text("時間選択")
                        )
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              SizedBox( //----------------------------------------------------------------------評価
                width: MediaQuery.of(context).size.width*0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //中央寄せにする
                  children: [
                    Text(
                      "評価",
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                    IconButton( //評価1
                      onPressed: (){
                        FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
                        setState(() {
                          _evaluation=1;
                        });
                      },
                      icon: Icon(Icons.star),
                      iconSize: 35,
                      color:_evaluation>=1? Color.fromARGB(255, 255, 217, 0):Colors.grey,
                    ),
                    IconButton( //評価2
                      onPressed: (){
                        FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
                        setState(() {
                          _evaluation=2;
                        });
                      },
                      icon: Icon(Icons.star),
                      iconSize: 35,
                      color:_evaluation>=2? Color.fromARGB(255, 255, 217, 0):Colors.grey,
                    ),
                    IconButton( //評価3
                      onPressed: (){
                        FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
                        setState(() {
                          _evaluation=3;
                        });
                      },
                      icon: Icon(Icons.star),
                      iconSize: 35,
                      color:_evaluation>=3? Color.fromARGB(255, 255, 217, 0):Colors.grey,
                    ),
                    IconButton( //評価4
                      onPressed: (){
                        FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
                        setState(() {
                          _evaluation=4;
                        });
                      },
                      icon: Icon(Icons.star),
                      iconSize: 35,
                      color:_evaluation>=4? Color.fromARGB(255, 255, 217, 0):Colors.grey,
                    ),
                    IconButton( //評価5
                      onPressed: (){
                        FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
                        setState(() {
                          _evaluation=5;
                        });
                      },
                      icon: Icon(Icons.star),
                      iconSize: 35,
                      color:_evaluation>=5? Color.fromARGB(255, 255, 217, 0):Colors.grey,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20,),

              SizedBox( //-------------------------------------------------メモ（複数行入力フォーム）
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  maxLines: null, //行数無制限
                  keyboardType: TextInputType.multiline, //改行しやすくなる
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "メモ"
                  ),
                ),
              ),

              SizedBox(height: 20,),

            ],
          ),
        )
      ),
    );
  }
}

class MovieRegistar extends StatelessWidget { //地上波登録用の画面

  const MovieRegistar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: (){
              },
              child: const Text("保存して閉じる"),
            ),
          ),
          Text("映画登録")
        ],
      ),
    );
  }
}