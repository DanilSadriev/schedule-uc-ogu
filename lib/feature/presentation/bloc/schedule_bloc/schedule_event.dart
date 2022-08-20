import 'package:equatable/equatable.dart';

// события расписания
abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object?> get props => [];
}

//показ расписания
class ScheduleView extends ScheduleEvent {
  final DateTime date;
  final String? group;

  const ScheduleView(this.date, this.group);
}

class ScheduleUpdateSettingsEvent extends ScheduleEvent {
  const ScheduleUpdateSettingsEvent({
    this.lectureBreaks,
    this.colorfulLection,
    this.finishedLecture,
    this.calendarFormat,
  });

  final bool? lectureBreaks;
  final bool? colorfulLection;
  final bool? finishedLecture;
  final int? calendarFormat;
}
