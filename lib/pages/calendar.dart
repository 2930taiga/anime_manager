import 'package:flutter/material.dart'; // これがないとWidgetが使えない

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("カレンダー"),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: Center(
        child: Text(
          "データが登録されていません",
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey
          ),
        ),
      ),
    );
  }
}