import 'package:equatable/equatable.dart';
import 'package:raspisanie/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:raspisanie/core/error/usecases/usecase.dart';
import 'package:raspisanie/feature/domain/entities/call_schedule.dart';
import 'package:raspisanie/feature/domain/repository/call_schedule_repository.dart';

class GetCallSchedule extends UseCase<CallSchedule, GetCallScheduleParams> {
  final CallScheduleRepository callScheduleRepository;

  GetCallSchedule(this.callScheduleRepository);

  @override
  Future<Either<Failure, CallSchedule>> call(
      GetCallScheduleParams params) async {
    return await callScheduleRepository.getCallSchedule(params.remote);
  }
}

class GetCallScheduleParams extends Equatable {
  final bool remote;

  const GetCallScheduleParams(this.remote);

  @override
  List<Object?> get props => [remote];
}
