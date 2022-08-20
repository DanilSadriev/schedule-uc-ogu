import 'package:raspisanie/core/error/exception.dart';
import 'package:raspisanie/feature/data/datasources/call_schedule_local_data_source.dart';
import 'package:raspisanie/feature/data/datasources/call_schedule_remote_data_source.dart';
import 'package:raspisanie/feature/data/models/call_schedule_model.dart';
import 'package:raspisanie/feature/domain/entities/call_schedule.dart';
import 'package:raspisanie/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:raspisanie/feature/domain/repository/call_schedule_repository.dart';

class CallScheduleRepositoryImpl implements CallScheduleRepository {
  final CallScheduleRemoteDataSource remoteDataSource;
  final CallScheduleLocalDataSource localDataSource;

  CallScheduleRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, CallSchedule>> getCallSchedule(bool remote) async {
    try {
      CallScheduleModel calls;
      if (remote) {
        calls = await remoteDataSource.getCallSchedule();
        await localDataSource.setCallSchedule(calls);
      } else {
        calls = await localDataSource.getCallSchedule();
      }
      return Right(calls);
    } on CacheException {
      var newCalls = await remoteDataSource.getCallSchedule();

      await localDataSource.setCallSchedule(newCalls);
      return Right(newCalls);
    } on ServerException {
      return const Left(ServerFailure());
    }
  }
}
