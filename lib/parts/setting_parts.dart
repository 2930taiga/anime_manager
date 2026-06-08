import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  //アイコン情報
  final IconData icon;
  //アイコンカラー
  final Color iconColor;
  //タイトルテキスト
  final String titleText;
  //サブテキスト
  final String subText;

  const SettingCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.titleText,
    required this.subText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 7
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Padding( //アイコン部分
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 7,
              vertical: 7
            ),
            child: Container( //アイコンの外枠
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: iconColor.withValues(alpha: 0.2)
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 7,
              vertical: 7
            ),
              child: Icon( //アイコン
                icon,
                size: 40,
                color: iconColor,
              ),
            ),
          ),


          Expanded( //中央のタイトルとサブテキスト
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 10
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black
                    ),
                  ),
                  Text(
                    subText,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey
                    ),
                  )
                ],
              ),
            )
          ),
          

          Padding( //右側の＞アイコン
            padding: EdgeInsetsGeometry.only(
              right: 5
            ),
            child: Icon(
              Icons.navigate_next,
              size: 40,
            ),
          )
        ],
      ),
    );
  }
}

//削除用のカード
class SettingDeleteCard extends StatelessWidget {
  //アイコン情報
  final IconData icon;
  //アイコンカラー
  final Color iconColor;
  //タイトルテキスト
  final String titleText;
  //サブテキスト
  final String subText;

  const SettingDeleteCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.titleText,
    required this.subText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 7
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Padding( //アイコン部分
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 7,
              vertical: 7
            ),
            child: Container( //アイコンの外枠
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: iconColor.withValues(alpha: 0.2)
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 7,
              vertical: 7
            ),
              child: Icon( //アイコン
                icon,
                size: 40,
                color: iconColor,
              ),
            ),
          ),


          Expanded( //中央のタイトルとサブテキスト
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 10
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.red
                    ),
                  ),
                  Text(
                    subText,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey
                    ),
                  )
                ],
              ),
            )
          ),
          

          Padding( //右側の＞アイコン
            padding: EdgeInsetsGeometry.only(
              right: 5
            ),
            child: Icon(
              Icons.navigate_next,
              size: 40,
            ),
          )
        ],
      ),
    );
  }
}

//ナビゲーションが無いカード
class SettingNonNavigationCard extends StatelessWidget {
  //アイコン情報
  final IconData icon;
  //アイコンカラー
  final Color iconColor;
  //タイトルテキスト
  final String titleText;
  //タイトルテキストの色
  final Color titleTextColor;
  //サブテキスト
  final String subText;

  const SettingNonNavigationCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.titleText,
    required this.titleTextColor,
    required this.subText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 7
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Padding( //アイコン部分
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 7,
              vertical: 7
            ),
            child: Container( //アイコンの外枠
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: iconColor.withValues(alpha: 0.2)
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 7,
              vertical: 7
            ),
              child: Icon( //アイコン
                icon,
                size: 40,
                color: iconColor,
              ),
            ),
          ),


          Expanded( //中央のタイトルとサブテキスト
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 10
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: titleTextColor
                    ),
                  ),
                  Text(
                    subText,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey
                    ),
                  )
                ],
              ),
            )
          ),
          

          // Padding( //右側の＞アイコン
          //   padding: EdgeInsetsGeometry.only(
          //     right: 5
          //   ),
          //   child: Icon(
          //     Icons.navigate_next,
          //     size: 40,
          //   ),
          // )
        ],
      ),
    );
  }
}