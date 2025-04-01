import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkInputPage extends StatelessWidget {
  final DateTime selectedDate;

  WorkInputPage({required this.selectedDate});

  final List<String> workTypes = ['D(주간)', 'N(야간)', 'O(Off)'];

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('근무 입력 ($formattedDate)'),
      ),
      body: ListView.builder(
        itemCount: workTypes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(workTypes[index]),
            onTap: () {
              // 근무 선택 후 뒤로 가기
              Navigator.pop(context, workTypes[index]);
            },
          );
        },
      ),
    );
  }
}
