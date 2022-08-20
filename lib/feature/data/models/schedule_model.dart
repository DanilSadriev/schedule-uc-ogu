import 'package:raspisanie/feature/domain/entities/lesson.dart';

// модель расписания
class ScheduleModel extends Lesson {
  const ScheduleModel({
    required time,
    required nomer,
    required name,
    required audience,
    required groupOrTeacher,
  }) : super(
          time: time,
          nomer: nomer,
          name: name,
          audience: audience,
          groupOrTeacher: groupOrTeacher,
        );

  factory ScheduleModel.fromJson(Map<String, dynamic> html) {
    if (html.isEmpty) {
      return ScheduleModel(
        time: const [],
        nomer: '',
        name: '',
        audience: '',
        groupOrTeacher: '',
      );
    } else {
      return ScheduleModel(
        time: html['time'],
        nomer: html['nomer'],
        name: html['name'],
        audience: html['audience'],
        groupOrTeacher: html['groupOrTeacher'],
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'nomer': nomer,
      'name': name,
      'audience': audience,
      'groupOrTeacher': groupOrTeacher,
    };
  }
}
