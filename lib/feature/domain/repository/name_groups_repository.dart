import 'package:dartz/dartz.dart';
import 'package:raspisanie/feature/domain/entities/name_groups.dart';

import '../../../core/error/failure.dart';

abstract class NameGroupsRepository {
  Future<Either<Failure, NameGroups>> getGroups();
}
