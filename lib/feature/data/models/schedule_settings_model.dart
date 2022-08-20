import 'dart:convert';

import '../../domain/entities/schedule_settings.dart';

class ScheduleSettingsModel extends ScheduleSettings {
  const ScheduleSettingsModel(
      {required lectureBreaks,
      required colorfulLecture,
      required finishedLecture,
      required calendarFormat})
      : super(
          lectureBreaks: lectureBreaks,
          colorfulLecture: colorfulLecture,
          finishedLecture: finishedLecture,
          calendarFormat: calendarFormat,
        );

  factory ScheduleSettingsModel.fromRawJson(String str) =>
      ScheduleSettingsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ScheduleSettingsModel.fromJson(Map<String, dynamic> json) =>
      ScheduleSettingsModel(
        lectureBreaks: json['lecture_breaks'],
        colorfulLecture: json['colorful_lecture'],
        finishedLecture: json['finished_lecture'],
        calendarFormat: json['calendar_format'],
      );

  Map<String, dynamic> toJson() => {
        'lecture_breaks': lectureBreaks,
        'colorful_lecture': colorfulLecture,
        'finished_lecture': finishedLecture,
        'calendar_format': calendarFormat,
      };
}
