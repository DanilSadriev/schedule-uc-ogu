import 'dart:convert';

import 'package:raspisanie/core/error/exception.dart';
import 'package:raspisanie/feature/data/models/call_schedule_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CallScheduleLocalDataSource {
  Future<CallScheduleModel> getCallSchedule();
  Future<void> setCallSchedule(CallScheduleModel callScheduleModel);
}

class CallScheduleLocalDataSourceImpl implements CallScheduleLocalDataSource {
  final SharedPreferences sharedPreferences;

  CallScheduleLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<CallScheduleModel> getCallSchedule() {
    String? data = sharedPreferences.getString('callSchedule');
    if (data == null) {
      throw CacheException('The call schedule are not set');
    }
    return Future.value(CallScheduleModel.fromJson(json.decode(data)));
  }

  @override
  Future<void> setCallSchedule(CallScheduleModel callScheduleModel) async {
    final String data = callScheduleModel.toRawJson();
    sharedPreferences.setString('callSchedule', data);
  }
}
