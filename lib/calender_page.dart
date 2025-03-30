import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'work_input_page.dart';
import 'storage/work_schedule_storage.dart';

import 'alarm/alarm_manager.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, String> _workSchedule = {};

  DateTime _stripTime(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  @override
  void initState() {
    super.initState();
    _loadWorkSchedule();
  }

  void _loadWorkSchedule() async {
    final data = await WorkScheduleStorage.load();
    setState(() {
      _workSchedule = data;
    });
  }

  void _saveWorkSchedule() {
    WorkScheduleStorage.save(_workSchedule);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('근무표 달력'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              final dateKey = _stripTime(day);
              final workType = _workSchedule[dateKey];
              if (workType != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${day.day}'),
                    Text(
                      workType,
                      style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                    ),
                  ],
                );
              }
              return null;
            },
            selectedBuilder: (context, day, focusedDay) {
              final dateKey = _stripTime(day);
              final workType = _workSchedule[dateKey];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${day.day}',
                      style: TextStyle(color: Colors.white),
                    ),
                    if (workType != null)
                      Text(
                        workType,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          onDaySelected: (selectedDay, focusedDay) async {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });

            final workType = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => WorkInputPage(selectedDate: selectedDay),
              ),
            );

            if (workType != null) {
              final strippedDate = _stripTime(selectedDay);

              setState(() {
                _workSchedule[strippedDate] = workType;
              });
              _saveWorkSchedule();

              // 알람 설정
              DateTime alarmTime = DateTime(
                strippedDate.year,
                strippedDate.month,
                strippedDate.day,
                workType.startsWith('D') ? 6 : (workType.startsWith('N') ? 17 : 9),
                0,
              );

              AlarmManager.setAlarm(alarmTime); // native alarm 호출
            }
          },
        ),
      ),
    );
  }
}
