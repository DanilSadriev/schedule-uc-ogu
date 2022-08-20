import 'package:equatable/equatable.dart';
import 'package:raspisanie/feature/domain/entities/lesson.dart';

import '../../../domain/entities/schedule_settings.dart';

// состояния расписания
abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object?> get props => [];
}

//ещё ничего не загрузилось
class ScheduleEmpty extends ScheduleState {}

//загружается
class ScheduleLoading extends ScheduleState {}

//загрузилось
class ScheduleLoaded extends ScheduleState {
  final List<Lesson> schedules;
  final ScheduleSettings scheduleSettings;

  const ScheduleLoaded(this.schedules, this.scheduleSettings);

  @override
  List<Object?> get props => [schedules, scheduleSettings];
}

//ошибка
class ScheduleError extends ScheduleState {
  final String message;

  const ScheduleError({required this.message});

  @override
  List<Object?> get props => [message];
}
