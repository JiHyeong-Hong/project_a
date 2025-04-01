import 'package:flutter/material.dart';
import 'package:project_a/calender_page.dart';
import 'package:project_a/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init(); // 알람 초기화
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