import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WorkScheduleStorage {
  static const _key = 'workSchedule';

  static String _dateToString(DateTime date) =>
      '${date.year}-${date.month}-${date.day}';

  static DateTime _stringToDate(String str) {
    final parts = str.split('-').map(int.parse).toList();
    return DateTime(parts[0], parts[1], parts[2]);
  }

  static Future<void> save(Map<DateTime, String> workSchedule) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonMap = workSchedule.map((key, value) => MapEntry(_dateToString(key), value));
    final jsonString = json.encode(jsonMap);
    await prefs.setString(_key, jsonString);

    // ✅ 디버깅 로그
    print('[Storage] 저장 완료: $jsonString');
  }

  static Future<Map<DateTime, String>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    // ✅ 디버깅 로그
    print('[Storage] 로딩 시도: $jsonString');

    if (jsonString == null) {
      print('[Storage] 저장된 데이터 없음');
      return {};
    }

    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final result = jsonMap.map((key, value) =>
        MapEntry(_stringToDate(key), value.toString()));

    // ✅ 디버깅 로그
    print('[Storage] 로딩 완료: $result');
    return result;
  }
}
