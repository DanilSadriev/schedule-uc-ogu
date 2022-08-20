import 'package:equatable/equatable.dart';

class ScheduleSettings extends Equatable {
  const ScheduleSettings({
    required this.lectureBreaks,
    required this.colorfulLecture,
    required this.finishedLecture,
    required this.calendarFormat,
  });

  final bool lectureBreaks;
  final bool colorfulLecture;
  final bool finishedLecture;
  final int calendarFormat;

  @override
  List<Object?> get props =>
      [lectureBreaks, colorfulLecture, finishedLecture, calendarFormat];
}
