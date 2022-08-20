import 'package:dartz/dartz.dart';
import 'package:raspisanie/core/error/failure.dart';
import 'package:raspisanie/feature/domain/entities/lesson.dart';

import '../entities/schedule_settings.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, List<Lesson>>> getAllSchedule(
      DateTime date, String group); //для получения расписания на день
  Future<void> setSettings(ScheduleSettings settings);
  Future<ScheduleSettings> getSettings();
}
