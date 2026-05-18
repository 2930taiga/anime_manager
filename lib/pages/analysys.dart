import 'package:flutter/material.dart'; // これがないとWidgetが使えない

//分析ページ
class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分析"),
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