import 'package:raspisanie/feature/data/datasources/schedule_remote_data_source.dart';
import 'package:raspisanie/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:raspisanie/feature/domain/entities/lesson.dart';
import 'package:raspisanie/feature/domain/repository/schedule_repository.dart';

import '../../../core/error/exception.dart';
import '../../domain/entities/schedule_settings.dart';
import '../datasources/schedule_local.dart';
import '../models/schedule_settings_model.dart';

// модель расписания
class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource remoteDataSource;
  final ScheduleLocalData localDataSource;

  ScheduleRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Lesson>>> getAllSchedule(
      DateTime date, String group) async {
    try {
      final remoteSchedule = await remoteDataSource.getAllSchedule(date, group);
      return Right(remoteSchedule);
    } on ServerException {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<ScheduleSettings> getSettings() async {
    try {
      final localSettings = await localDataSource.getSettingsFromCache();
      return localSettings;
    } on CacheException {
      const newLocalSettings = ScheduleSettingsModel(
        lectureBreaks: false,
        colorfulLecture: false,
        finishedLecture: false,
        calendarFormat: 2,
      );
      await localDataSource.setSettingsToCache(newLocalSettings);
      return newLocalSettings;
    }
  }

  @override
  Future<void> setSettings(ScheduleSettings settings) async {
    localDataSource.setSettingsToCache(ScheduleSettingsModel(
      lectureBreaks: settings.lectureBreaks,
      colorfulLecture: settings.colorfulLecture,
      finishedLecture: settings.finishedLecture,
      calendarFormat: settings.calendarFormat,
    ));
  }
}
