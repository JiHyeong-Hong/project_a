import 'package:flutter/material.dart';
import 'package:project_a/calender_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '근무 알람 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalendarPage(), // 홈 화면 = 달력 페이지
    );
  }
}