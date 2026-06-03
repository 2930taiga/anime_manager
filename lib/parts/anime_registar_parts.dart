import 'package:anime_administration/parameter_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:anime_administration/models/genre.dart';
import 'package:anime_administration/providers/anime_input_provider.dart';
import 'package:anime_administration/providers/isar_provider.dart';
import 'package:intl/intl.dart';
import 'package:anime_administration/models/anime.dart';

//-----------------------------------ドロップダウンメニュー--------------------------
class StatusDropDownMenu extends ConsumerWidget {

  const StatusDropDownMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
        child: DropdownMenu(
          width: MediaQuery.of(context).size.width*0.45,
          label: Text("ステータス"),
          onSelected: (value){ //何かが選ばれたらproviderの値を書き換える 
            if(value==null) {
              //print("何も選ばれてません");
              return;
            };

            //数値をStatusのenumに変換
            final selectedStatus=Status.values[value];
            //providerを更新
            ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(status: selectedStatus);
            //正しい値が入力されているflagをtrueに
            ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(status: true);
          },
          dropdownMenuEntries: const[
            DropdownMenuEntry(value: 0, label: "未視聴"),
            DropdownMenuEntry(value: 1, label: "視聴中"),
            DropdownMenuEntry(value: 2, label: "視聴済"),
            DropdownMenuEntry(value: 3, label: "視聴中止"),
            DropdownMenuEntry(value: 4, label: "中断"),
          ]
        ),
    );
  }
}

//-----------------------------------タイトル--------------------------
class InputFieldTitle extends ConsumerStatefulWidget {
  const InputFieldTitle({super.key});

  @override
  ConsumerState<InputFieldTitle> createState() => _InputFieldTitleState();
}

class _InputFieldTitleState extends ConsumerState<InputFieldTitle> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (text){
          if(text=="" || text==null){ //入力が正しくない
            return "タイトルを入力してください";
          }
          else{ //入力が正しい
            return null;
          }
        },
        onChanged: (text){
          if(text==""){ //入力が正しくない
            //providerのflagを書き換える
            ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(title: text);
            ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(title: false);
          }
          else{ //入力が正しい
            //providerのflagを書き換える
            ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(title: true);
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "タイトル",
        ),
      ),
    );
  }
}

//-----------------------------------タイトル（かな）--------------------------
class InputFieldTitleKana extends ConsumerStatefulWidget {
  const InputFieldTitleKana({super.key});

  @override
  ConsumerState<InputFieldTitleKana> createState() => _InputFieldTitleKanaState();
}

class _InputFieldTitleKanaState extends ConsumerState<InputFieldTitleKana> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (text){
          if(text=="" || text==null){ //入力が正しくない
            return "タイトル（かな）を入力してください";
          }
          else{
            return null;
          }
        },
        onChanged: (text){
          if(text==""){ //入力が正しくない
            //providerのflagを書き換える
            ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(titleKana: false);
          }
          else{
            //providerの値を更新
            ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(titleKana: text);
            ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(titleKana: true);
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "タイトル（かな）",
        ),
      ),
    );
  }
}

//-----------------------------------日付欄--------------------------
class InputFieldDate extends ConsumerStatefulWidget {
  const InputFieldDate({super.key});

  @override
  ConsumerState<InputFieldDate> createState() => _InputFieldDateState();
}

class _InputFieldDateState extends ConsumerState<InputFieldDate> {
  //テキストコントローラを登録
  final TextEditingController _dateController = TextEditingController();

  //テキストコントローラのメモリ解放
  @override
  void dispose(){
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width*0.9,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text){
              //正しい入力がされているかを判定
              if(text!=null){
                try{
                  //正しい値が入力されていないとここでエラーになる
                  DateFormat("yyyy/MM/dd").parseStrict(text);
                  return null;
                }
                catch(e){
                  //正しい値が入力されていない
                  return "正しい値を入力してください";
                }
              }
            },
            onChanged: (text){
              //正しい入力がされているかを判定
                try{
                  //正しい値が入力されていないとここでエラーになる
                  DateTime inputDate = DateFormat("yyyy/MM/DD").parseStrict(text);
                  //正しい値が入力されているならproviderの値を更新
                  ref.read(animeInputProvider.notifier).state = ref.read(animeInputProvider).copyWith(date: inputDate);
                  ref.read(animeCorrectInputProvider.notifier).state = ref.read(animeCorrectInputProvider).copyWith(date: true);
                }
                catch(e){
                  //正しい値が入力されていない
                  ref.read(animeCorrectInputProvider.notifier).state = ref.read(animeCorrectInputProvider).copyWith(date: false);
                }
            },
            controller: _dateController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "日付",
            ),
          ),
        ),

        SizedBox(height: 6,),

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.44,
                child: ElevatedButton(
                  onPressed: (){
                    DateTime selectedDate=inputDate_today();
                    //テキストフィールド用にフォーマット
                    String formattedDate="${selectedDate.year}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day.toString().padLeft(2, '0')}";
                    //テキストコントローラの値を更新
                    _dateController.text=formattedDate;
                    //テキストフィールドのフォーカスを外す
                    FocusManager.instance.primaryFocus?.unfocus();
                    //providerに値を入れる
                    ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(date: selectedDate);
                    //ボタンを押すと必ず正しい値が入力されるので，flagをtrueにする
                    ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(date: true);
                  }, 
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_today_outlined),
                      SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                      const Text("今日の日付")
                    ],
                  )
                  )
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02), //ボタン同士がぴったりくっついてるとダサいので，間隔を開ける
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.44,
                child: ElevatedButton(
                  onPressed: () async {
                    DateTime selectedDate = await inputDate_select(context);
                    //テキストフィールド用にフォーマット
                    String formattedDate = "${selectedDate.year}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day.toString().padLeft(2, '0')}";
                    //テキストコントローラの値を更新
                    _dateController.text = formattedDate;
                    //テキストフィールドのフォーカスを外す
                    FocusManager.instance.primaryFocus?.unfocus();
                    FocusManager.instance.primaryFocus?.unfocus();
                    //providerに値を入れる
                    ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(date: selectedDate);
                    //ボタンを押すと必ず正しい値が入力されるので，flagをtrueにする
                    ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(date: true);
                  }, 
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_today),
                      SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                      const Text("日付選択"),
                      SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                      const Icon(Icons.navigate_next_outlined)
                    ],
                  )
                  )
              )
            ],
          ),
        )
      ],
    );
  }
}

//-----------------------------------日付入力用の関数--------------------------
//今日の日付を入力する関数
DateTime inputDate_today() {
  //今日の日付を取得
  DateTime date = DateTime.now();
  // //日付の見た目をフォーマット
  // String FormattedDate = "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";

  return date;
}

//カレンダーを表示し，任意の日付を入力する関数
Future<DateTime> inputDate_select(BuildContext context) async {
  final DateTime? picked = await showDatePicker( //カレンダーを表示して，日付選択画面を出す
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1990),
    lastDate: DateTime(2100)
    );

    //入力された日付を変数に代入
    if (picked != null){
      //入力された日付を代入
      DateTime date= picked;

      return date;
    }

    //もし何も入力されていなければ空白を返す
    return DateTime.now();
  }

//-----------------------------------放送年入力欄--------------------------
class InputOnAirDate extends ConsumerStatefulWidget {
  const InputOnAirDate({super.key});

  @override
  ConsumerState<InputOnAirDate> createState() => _InputOnAirDateState();
}

class _InputOnAirDateState extends ConsumerState<InputOnAirDate> {
  final TextEditingController _onAirDateController = TextEditingController();

  @override
  void dispose(){
    _onAirDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
      child: Row(
        children: [
          SizedBox( //年入力欄
            width: MediaQuery.of(context).size.width*0.4,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (text){
                //入力が数字かつ1900~2100に収まっているかを確認
                //入力が空
                if(text==null){
                  return "値を入力してください";
                }
                //入力が数字ではない
                if(int.tryParse(text)==null){
                  return "数値を入力してください";
                }
                int inputYear=int.tryParse(text) ?? 0;
                //1900~2100に収まっていない
                if(inputYear>2100 || inputYear<1900){
                  return "1900~2100で入力してください";
                }
              },
              onChanged: (text){
                //入力が空白 or 文字
                if(text=="" || int.tryParse(text)==null){
                  ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(onAirYear: false);
                  return;
                } 
                
                int inputNum = int.tryParse(text) ?? 0;

                //入力が1900~2100に収まっていない
                if(inputNum>2100 || inputNum<1900){
                  ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(onAirYear: false);
                  return;
                }

                //入力が正しい
                ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(onAirYear: inputNum);
                ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(onAirYear: true);

              },
              controller: _onAirDateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "放送年",
              ),
            ),
          ),

          IconButton( //年選択画面を出すボタン
            onPressed:() async {
              //年選択画面を表示
              int? selectedYear = await inputOnAirYear(context);
              
              if(selectedYear==null) return;

              //テキストコントローラの値を更新
              _onAirDateController.text=selectedYear.toString();
              //providerの値を更新
              ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(onAirYear: selectedYear);
              ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(onAirYear: true);
            },
            icon:Icon(
              Icons.calendar_month_outlined,
              size:29,
            )
          ),

          Expanded(child: SizedBox()),
          
          DropdownMenu(
            label: Text("季節"),
            width: MediaQuery.of(context).size.width*0.3,
            onSelected: (value) {
              //選択されたステータスを変換する
              if(value==null){
                return;
              }
              //入力がされていたらproviderの値を更新
              ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(season: OnAirSeason.values[value]);
              ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(season: true);
            },
            dropdownMenuEntries: const[
              DropdownMenuEntry(value: 0, label: "春"),
              DropdownMenuEntry(value: 1, label: "夏"),
              DropdownMenuEntry(value: 2, label: "秋"),
              DropdownMenuEntry(value: 3, label: "冬"),
            ]
          )
        ],
      ),
    );
  }
}

//-----------------------------------放送年入力用の関数--------------------------
//ボタンを押すと，放送年選択のスロットを表示する関数を宣言
Future<int?> inputOnAirYear(BuildContext context) async{
  int _pickerSelected_onAirDate=DateTime.now().year;

  return await showModalBottomSheet<int>(
    context: context, 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(0) //下から出てくるやつの角を四角くする
    ),
    builder: (context){
      return Container(
        width: MediaQuery.of(context).size.width*1.0,
        height: 250,
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
                              //ボタン選択時点での入力を保持しておく
                              Navigator.of(context).pop(); //画面を戻る
                              FocusManager.instance.primaryFocus?.unfocus(); //テキストのフォーカスを外す
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
                            "放送年選択",
                            style: TextStyle(
                              fontSize: 20
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.2,
                        child: Center(
                          child: TextButton( //放送年選択画面の保存ボタン
                            onPressed: (){
                              Navigator.pop(context,_pickerSelected_onAirDate); //前の画面に戻りつつ，値を返す
                              FocusManager.instance.primaryFocus?.unfocus(); //テキストのフォーカスを外す
                              //print("保存された");
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
                //初期値を今の年に
                scrollController: FixedExtentScrollController(
                  initialItem: DateTime.now().year-1900
                ),
                onSelectedItemChanged: (index){
                  _pickerSelected_onAirDate=index+1900;
                },
                //1900年~2100年まで
                children: List.generate(201,(index){
                  return Center(
                    child: Text(
                      "${index+1900}"
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

//-----------------------------------ジャンル入力ボタン--------------------------
class SelectedGenreText extends ConsumerStatefulWidget {
  const SelectedGenreText({super.key});

  @override
  ConsumerState<SelectedGenreText> createState() => _SelectedGenreTextState();
}

class _SelectedGenreTextState extends ConsumerState<SelectedGenreText> {
  //入力されているジャンルを表示するテキスト
  String select_genre_text = "ジャンルが選択されていません";
  //選択されているジャンルのidを保持するリスト
  Set<int> selected_genre_id={};

  //データベースに登録されているジャンルのダイアログを表示させる関数
  Future<void> showSelectGenreDialog(Isar isar) async{
    //データベースからデータを取り出す
    List<Genre> _genres = await isar.genres.where().findAll();
    //リストの要素数分，中身がfalseのリストを作る
    List<bool> select_genre_flag=List.filled(_genres.length, false);
    //ループカウント用
    int i = 0;
    //idが既に登録されているかを確かめる
    for(Genre gen in _genres){
      if(selected_genre_id.contains(gen.id)){
        select_genre_flag[i]=true;
      }
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
                height: 500,
                child: Column(
                  children: [

                    SizedBox(height: 20,),

                    const Text(
                      "ジャンルを選択してください",
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),

                    SizedBox(height: 20,),

                    Expanded(
                      child: _genres.isEmpty 
                      ? Center(
                        child: const Text(
                          "ジャンルが登録されていません",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey
                          ),
                          ),
                      )
                      : Scrollbar( //ジャンルのリストが空でないならジャンル一覧を表示する
                        thumbVisibility: true,
                        child: ListView.builder(
                          itemCount: _genres.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: SwitchListTile(
                                  activeThumbColor: Colors.white, //on時のつまみ
                                  activeTrackColor: Color.fromARGB(255,188, 240, 121), //on時の背景
                                  //inactiveThumbColor: Colors.white, //of時のつまみ
                                  //inactiveTrackColor: Color.fromARGB(255, 197, 197, 197), //off時の背景
                                  secondary: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(
                                        255,
                                        _genres[index].redValue,
                                        _genres[index].greenValue,
                                        _genres[index].blueValue
                                      ).withValues(alpha: 0.08),
                                      border: Border.all(
                                        color: Color.fromARGB(
                                          255,
                                          _genres[index].redValue,
                                          _genres[index].greenValue,
                                          _genres[index].blueValue
                                        ).withValues(alpha: 0.15),
                                      ),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Icon(
                                      IconShapeDatas[
                                        _genres[index].iconShape.index
                                      ],
                                      size: 25,
                                      color: Color.fromARGB(
                                        255,
                                        _genres[index].redValue,
                                        _genres[index].greenValue,
                                        _genres[index].blueValue
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    _genres[index].name,
                                    style: TextStyle(
                                      fontSize: 16
                                    ),
                                  ),
                                  value: select_genre_flag[index],
                                  onChanged: (bool value){ //あるジャンルが選択されたときの処理
                                    setStateDialog((){
                                      //off→onになったとき
                                      if(value==true){
                                        //選択されているジャンルのidを保持しておくSet内にidを追加
                                        //selected_genre_id.add(_genres[index].id);
                                        select_genre_flag[index]=true;
                                      }
                                      //on→offになったとき
                                      else{
                                        //選択されているジャンルのidを保持しておくSet内からidを削除
                                        //selected_genre_id.remove(_genres[index].id);
                                        select_genre_flag[index]=false;
                                      }
                                    });
                                  }
                                ),
                              ),
                            );
                          },
                        )
                      )
                    ),

                    const SizedBox(height: 20,),

                    SizedBox( //保存ボタン
                      width: MediaQuery.of(context).size.width*0.4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ElevatedButtons.backgroundColor,
                        ),
                        onPressed: (){
                          //登録されているジャンルのidを書き換える
                          int j=0; //ループカウント用
                          for(bool flag in select_genre_flag){
                            if(flag==true){
                              selected_genre_id.add(_genres[j].id);
                            }
                            else{
                              selected_genre_id.remove(_genres[j].id);
                            }
                            j=j+1;
                          }
                          //ジャンル表示テキストに表示する用のテキストを作成
                          //初期文字列
                          String genre_text_temp="";
                          //選択されているジャンルのSet<int>を小さい順に並び替え，文字列を作成
                          for(int _id in selected_genre_id.toList()..sort()){
                            //選択されているジャンルのidから，文字列を作成
                            genre_text_temp += _genres.firstWhere((g) => g.id == _id).name; //データベースからidが一致するものを探し出し，nameを取得する
                            //","で区切る
                            genre_text_temp += "，";
                          }

                          //最後の","を取る
                          if(genre_text_temp!=""){
                            genre_text_temp = genre_text_temp.substring(0 , genre_text_temp.length - 1 );
                          }

                          //もし文字列が空白のままなら，「ジャンルが選択されていません」に戻し，providerの値を更新する
                          if(genre_text_temp == ""){ //何も入力されていない
                            genre_text_temp = "ジャンルが選択されていません";
                            //providerの値を更新する
                            ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(genreId: false);
                          }
                          else{ //ジャンルが選択されている
                            //providerの値を更新する
                            ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(genreId: true);
                          }

                          //選択されているジャンルを表示するTextの中身を書き換える
                          setState(() {
                            select_genre_text=genre_text_temp;
                          });

                          //providerに結果を渡す
                          ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(genreId: selected_genre_id);
                          
                          //戻る
                          Navigator.pop(context);
                          //テキストのフォーカスを外す
                          FocusScope.of(context).unfocus();
                        },
                        child: Text(
                          "保存",
                          style: TextStyle(
                            color: ElevatedButtons.fontColor,
                            fontSize: 17
                          ),
                        )
                      ),
                    ),
                    

                    const SizedBox(height: 20,)
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    //providerからisarのインスタンスを取得
    final isar = ref.watch(isarProvider);
    
    return Column(
      children: [
        Container( //テキスト表示エリア
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

        SizedBox(height: 6,), //----------------------------------------

        SizedBox( //ジャンル選択ボタン
          width: MediaQuery.of(context).size.width*0.9,
          child: ElevatedButton(
            onPressed: (){
              showSelectGenreDialog(isar);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.local_offer),
                SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                const Text("ジャンル選択"),
                SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                const Icon(Icons.navigate_next)
              ],
            )
          ),
        ),
      ],
    );
  }
}

//-----------------------------------話数入力欄--------------------------
class InputFieldEpNum extends ConsumerStatefulWidget {
  const InputFieldEpNum({super.key});

  @override
  ConsumerState<InputFieldEpNum> createState() => _InputFieldEpNumState();
}

class _InputFieldEpNumState extends ConsumerState<InputFieldEpNum> {
  //コントローラを登録
  final TextEditingController _epNumController = TextEditingController();

  @override
  void dispose(){
    _epNumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width*0.9,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text){
              //入力された値を読み取る
              if(text!=null){
                int? inputValue = int.tryParse(text);
                //正しい値が入力されているかを判定する
                if(inputValue!=null){ //正しい
                  return null;
                }
                else{ //正しくない
                  return "正しい値を入力してください";
                }
              }
            },
            onChanged: (text){
              //入力された値を読み取る
              int? inputValue = int.tryParse(text);
              //正しい値が入力されているかを判定する
              if(inputValue!=null){ //正しい
                ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(epNum: int.tryParse(text));
                ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epNum: true);
              }
              else{ //正しくない
                ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epNum: false);
              }
            },
            controller: _epNumController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "話数",
            ),
          ),
        ),

        SizedBox(height: 6,),

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.255,
                child: ElevatedButton(
                  onPressed: (){
                    //TextFieldのフォーカスを外す
                    FocusManager.instance.primaryFocus?.unfocus();
                    //コントローラの中身を変える
                    _epNumController.text="12";
                    //providerの値を変更
                    ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(epNum: 12);
                    //ボタンを押すと必ず正しい値が入るので，flagをtrueにする
                    ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epNum: true);
                  }, 
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 2) //余白を小さくする
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.local_library_outlined),
                      SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                      const Text("12話")
                    ],
                  )
                )
              ),

              SizedBox(width: MediaQuery.of(context).size.width * 0.02), //ボタン同士がぴったりくっついてるとダサいので，間隔を開ける

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.255,
                child: ElevatedButton(
                  onPressed: (){
                    //TextFieldのフォーカスを外す
                    FocusManager.instance.primaryFocus?.unfocus();
                    //コントローラの中身を変える
                    _epNumController.text="24";
                    //providerの値を変更
                    ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(epNum: 24);
                    //ボタンを押すと必ず正しい値が入るので，flagをtrueにする
                    ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epNum: true);

                  }, 
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 2) //余白を小さくする
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.local_library_outlined),
                      SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                      const Text("24話")
                    ],
                  )
                )
              ),

              SizedBox(width: MediaQuery.of(context).size.width * 0.02), //ボタン同士がぴったりくっついてるとダサいので，間隔を開ける

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: ElevatedButton(
                  onPressed: () async{
                    final result = (await inputEpNum(context)).toString();
                    if(result!="null"){
                      //コントローラの中身を変える
                      _epNumController.text=result.toString();
                      //providerの値を変更
                      ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(epNum: int.tryParse(result));
                      //ボタンを押すと必ず正しい値が入るので，flagをtrueにする
                      ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epNum: true);
                    }
                  }, 
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 2) //余白を小さくする
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.local_library),
                      SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                      const Text("話数選択"),
                      SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                      const Icon(Icons.navigate_next)
                    ],
                  )
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//-----------------------------------話数入力用の関数--------------------------
//ボタンを押すと，話数選択のスロットを表示する関数を宣言
Future<int?> inputEpNum(BuildContext context) async{
  int _pickerSelected_EpNum=0;

  return await showModalBottomSheet<int>(
    context: context, 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(0) //下から出てくるやつの角を四角くする
    ),
    builder: (context){
      return Container(
        width: MediaQuery.of(context).size.width*1.0,
        height: 250,
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
                              //ボタン選択時点での入力を保持しておく
                              Navigator.of(context).pop(); //画面を戻る
                              FocusManager.instance.primaryFocus?.unfocus(); //テキストのフォーカスを外す
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
                              Navigator.pop(context,_pickerSelected_EpNum); //前の画面に戻りつつ，値を返す
                              FocusManager.instance.primaryFocus?.unfocus(); //テキストのフォーカスを外す
                              //print("保存された");
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
                children: List.generate(10000,(index){
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

//-----------------------------------時間入力用のTextField--------------------------
class InputFieldEpTime extends ConsumerStatefulWidget {
  const InputFieldEpTime({super.key});

  @override
  ConsumerState<InputFieldEpTime> createState() => _InputFieldEpTimeState();
}

class _InputFieldEpTimeState extends ConsumerState<InputFieldEpTime> {
  //テキストコントローラを作成
  final TextEditingController _epTimeController = TextEditingController();
  //正しい値が入力されているかどうかを判定するflag
  //あくまでTextFieldにエラーメッセージを表示するかどうかを判定するためのflag．保存時に確認する用ではない
  bool correctInputFlag=true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width*0.9,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text){
              //入力された値を読み取る
              if(text!=null){
                if(int.tryParse(text)==null){ //正しくない
                  return "正しい値を入力してください";
                }
                else{ //正しい
                  return null;
                }
              }
            },
            onChanged: (text){
              //入力された値 を読み取る
                if(int.tryParse(text)==null){ //正しくない
                  ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epTime: false);
                }
                else{ //正しい
                //providerの値を更新
                  ref.read(animeInputProvider.notifier).state = ref.read(animeInputProvider).copyWith(epTime: int.tryParse(text));
                  ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epTime: true);
                }
              },
            controller: _epTimeController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "1話あたりの時間(分)",
            ),
          ),
        ),

        SizedBox(height: 6,),

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.255,
                child: ElevatedButton(
                  onPressed: (){
                    //コントローラの値を更新
                    _epTimeController.text = "12";
                    //providerの値を書き換える
                    ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(epTime: 12);
                    //ボタンを押すと必ず正しい値が入るので，flagをtrueにする
                    ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epTime: true);
                  }, 
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 2) //余白を小さくする
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time),
                      SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                      const Text("12分")
                    ],
                  )
                )
              ),

              SizedBox(width: MediaQuery.of(context).size.width * 0.02), //ボタン同士がぴったりくっついてるとダサいので，間隔を開ける

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.255,
                child: ElevatedButton(
                  onPressed: (){
                    //コントローラの値を更新
                    _epTimeController.text = "24";
                    //providerの値を書き換える
                    ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(epTime: 24);
                    //ボタンを押すと必ず正しい値が入るので，flagをtrueにする
                    ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epTime: true);
                  }, 
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 2) //余白を小さくする
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time),
                      SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                      const Text("24分")
                    ],
                  )
                )
              ),

              SizedBox(width: MediaQuery.of(context).size.width * 0.02), //ボタン同士がぴったりくっついてるとダサいので，間隔を開ける

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: ElevatedButton(
                  onPressed: ()async {
                    //入力時点での入力値を保持しておく
                    String text_temp=_epTimeController.text;
                    final result=await inputEpTime(context);
                    if(result !=null){
                      //コントローラの値を更新
                      _epTimeController.text=result;
                      //providerの値を書き換える
                      ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(epTime: int.tryParse(result));
                      //ボタンを押すと必ず正しい値が入るので，flagをtrueにする
                      ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(epTime: true);
                    }
                    else{
                      _epTimeController.text=text_temp;
                    }
                  }, 
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 2) //余白を小さくする
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time_filled),
                      SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                      const Text("時間選択"),
                      SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                      const Icon(Icons.navigate_next)
                    ],
                  )
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//-----------------------------------時間入力用の関数--------------------------
//ボタンを押すと時間入力のスロットを表示する関数を宣言
Future<String?> inputEpTime(BuildContext context) async{
  //選択されている数値を保持する変数
  int _pickerSelected_Hour = 0;
  int _pickerSelected_Min = 0;
  //値がnullにならないための初期変数
  String _pickerSelected_text = "0:00";
  return await showModalBottomSheet<String>(
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
                              Navigator.of(context,).pop(); //画面を戻る
                              FocusManager.instance.primaryFocus?.unfocus(); //テキストのフォーカスを外す
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
                              _pickerSelected_text = (_pickerSelected_Hour*60 + _pickerSelected_Min).toString();
                              Navigator.pop(context,_pickerSelected_text); //画面を戻りつつ，値を返す
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


//-----------------------------------評価入力用の関数--------------------------
class EvaluationIcons extends ConsumerStatefulWidget {
  const EvaluationIcons({super.key});

  @override
  ConsumerState<EvaluationIcons> createState() => _EvaluationIconsState();
}

class _EvaluationIconsState extends ConsumerState<EvaluationIcons> {
  //初期値を宣言
  int _evaluation=0;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              //providerの評価を書き換える
              ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(evaluation: _evaluation);
              //正しく入力されているflagをtrueに
              ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(evaluation: true);
            },
            icon: const Icon(Icons.star),
            iconSize: 35,
            color:_evaluation>=1? Color.fromARGB(255, 255, 217, 0):Colors.grey,
          ),
          IconButton( //評価2
            onPressed: (){
              FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
              setState(() {
                _evaluation=2;
              });
              //providerの評価を書き換える
              ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(evaluation: _evaluation);
              //正しく入力されているflagをtrueに
              ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(evaluation: true);
            },
            icon: const Icon(Icons.star),
            iconSize: 35,
            color:_evaluation>=2? Color.fromARGB(255, 255, 217, 0):Colors.grey,
          ),
          IconButton( //評価3
            onPressed: (){
              FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
              setState(() {
                _evaluation=3;
              });
              //providerの評価を書き換える
              ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(evaluation: _evaluation);
              //正しく入力されているflagをtrueに
              ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(evaluation: true);
            },
            icon: const Icon(Icons.star),
            iconSize: 35,
            color:_evaluation>=3? Color.fromARGB(255, 255, 217, 0):Colors.grey,
          ),
          IconButton( //評価4
            onPressed: (){
              FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
              setState(() {
                _evaluation=4;
              });
              //providerの評価を書き換える
              ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(evaluation: _evaluation);
              //正しく入力されているflagをtrueに
              ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(evaluation: true);
            },
            icon: const Icon(Icons.star),
            iconSize: 35,
            color:_evaluation>=4? Color.fromARGB(255, 255, 217, 0):Colors.grey,
          ),
          IconButton( //評価5
            onPressed: (){
              FocusScope.of(context).unfocus(); //テキストのフォーカスを外す
              setState(() {
                _evaluation=5;
              });
              //providerの評価を書き換える
              ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(evaluation: _evaluation);
              //正しく入力されているflagをtrueに
              ref.read(animeCorrectInputProvider.notifier).state=ref.read(animeCorrectInputProvider).copyWith(evaluation: true);
            },
            icon: const Icon(Icons.star),
            iconSize: 35,
            color:_evaluation>=5? Color.fromARGB(255, 255, 217, 0):Colors.grey,
          ),
        ],
      ),
    );
  }
}

//-----------------------------------メモ--------------------------
//改行ができる
class InputFieldMemo extends ConsumerWidget {
  const InputFieldMemo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
      //height: 60,
      child: TextField(
        onChanged: (text){
          ref.read(animeInputProvider.notifier).state=ref.read(animeInputProvider).copyWith(memo: text);
        },
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "メモ",
        ),
      ),
    );
  }
}