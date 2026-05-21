import 'package:flutter/material.dart'; // これがないとWidgetが使えない

import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("カレンダー"),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime.utc(1990,1,1),
        lastDay: DateTime.utc(2100,12,31)
      )
    );
  }
}