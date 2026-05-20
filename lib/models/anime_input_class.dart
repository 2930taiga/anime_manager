//登録画面で入力中のデータを保持しておくクラス

enum Status{
  before,
  watching,
  complete,
  stop,
  pause
}

class AnimeInputData {
  final Status status;
  final String title;
  final String titleKana;
  final DateTime date;
  final Set<int> genreId;
  final int epNum;
  final int epTime;
  final int evaluation;
  final String memo;

  AnimeInputData({
    this.status = Status.before,
    this.title="",
    this.titleKana="",
    DateTime? date ,
    this.genreId = const <int>{},
    this.epNum=0,
    this.epTime=0,
    this.evaluation=0,
    this.memo=""
  }):date = date?? DateTime.now();

  AnimeInputData copyWith({
    Status? status,
    String? title,
    String? titleKana,
    DateTime? date,
    Set<int>? genreId,
    int? epNum,
    int? epTime,
    int? evaluation,
    String? memo,
  }) {
    return AnimeInputData(
      status: status ?? this.status,
      title: title ?? this.title,
      titleKana: titleKana ?? this.titleKana,
      date: date ?? this.date,
      genreId: genreId ?? this.genreId,
      epNum: epNum ?? this.epNum,
      epTime: epTime ?? this.epTime,
      evaluation: evaluation ?? this.evaluation,
      memo: memo ?? this.memo,
    );
  }
}