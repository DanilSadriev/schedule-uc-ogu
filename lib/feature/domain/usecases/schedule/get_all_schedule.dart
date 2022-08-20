import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:raspisanie/core/error/failure.dart';
import 'package:raspisanie/core/error/usecases/usecase.dart';
import 'package:raspisanie/feature/domain/entities/lesson.dart';
import 'package:raspisanie/feature/domain/repository/schedule_repository.dart';

class GetAllSchedule extends UseCase<List<Lesson>, ScheduleParams> {
  final ScheduleRepository scheduleRepository;

  GetAllSchedule(this.scheduleRepository);

  @override
  Future<Either<Failure, List<Lesson>>> call(ScheduleParams params) async {
    return await scheduleRepository.getAllSchedule(params.date, params.group);
  }
}

class ScheduleParams extends Equatable {
  final DateTime date;
  final String group;

  const ScheduleParams({required this.date, required this.group});

  @override
  List<Object?> get props => [date, group];
}
