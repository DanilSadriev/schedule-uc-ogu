// модель расписания звонков
import 'dart:convert';

import 'package:raspisanie/feature/domain/entities/call_schedule.dart';

class CallScheduleModel extends CallSchedule {
  const CallScheduleModel({
    required Map<String, List<String>> callWorkDays,
    required Map<String, List<String>> callSaturday,
    required Map<String, List<String>> callAbreviated,
  }) : super(
          callWorkDays: callWorkDays,
          callSaturday: callSaturday,
          callAbreviated: callAbreviated,
        );

  String toRawJson() => json.encode(tojson());

  Map<String, dynamic> tojson() => {
        'callWorkDays': callWorkDays,
        'callSaturday': callSaturday,
        'callAbreviated': callAbreviated,
      };

  factory CallScheduleModel.fromJson(Map<String, dynamic> json) {
    return CallScheduleModel(
      callWorkDays: parseJson(json['callWorkDays']),
      callSaturday: parseJson(json['callSaturday']),
      callAbreviated: parseJson(json['callAbreviated']),
    );
  }

  static Map<String, List<String>> parseJson(Map<String, dynamic> json) {
    Map<String, List<String>> map = {};

    for (var item in json.keys) {
      map[item] = List<String>.from(json[item]);
    }

    return map;
  }
}
