import 'package:dartz/dartz.dart';
import 'package:raspisanie/core/error/failure.dart';

// usecase
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseRight<Type, Params> {
  Future<Type> call(Params params);
}
