import 'package:flutter/services.dart';

class AlarmManager {
  static const MethodChannel _channel = MethodChannel('alarm_channel');

  static Future<void> setAlarm(DateTime time) async {
    try {
      await _channel.invokeMethod('setAlarm', {
        'year': time.year,
        'month': time.month,
        'day': time.day,
        'hour': time.hour,
        'minute': time.minute,
      });
      print('[AlarmManager] 알람 설정: $time');
    } on PlatformException catch (e) {
      print('[AlarmManager] 오류: ${e.message}');
    }
  }
}
