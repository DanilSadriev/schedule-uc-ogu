import 'package:dartz/dartz.dart';
import 'package:raspisanie/core/error/failure.dart';
import 'package:raspisanie/feature/domain/entities/call_schedule.dart';

abstract class CallScheduleRepository {
  Future<Either<Failure, CallSchedule>> getCallSchedule(
      bool remote); //для получения расписания звонков
}
