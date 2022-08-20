import 'package:raspisanie/core/error/exception.dart';
import 'package:raspisanie/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:raspisanie/feature/data/datasources/name_groups_remote.dart';
import 'package:raspisanie/feature/data/models/name_groups_model.dart';
import 'package:raspisanie/feature/domain/entities/name_groups.dart';
import 'package:raspisanie/feature/domain/repository/name_groups_repository.dart';

class NameGroupsRepositoryImpl implements NameGroupsRepository {
  final NameGroupsRemote nameGroupsRemote;

  NameGroupsRepositoryImpl({required this.nameGroupsRemote});

  @override
  Future<Either<Failure, NameGroups>> getGroups() async {
    try {
      NameGroupsModel groupsModel = await nameGroupsRemote.getGroups();
      return Right(groupsModel);
    } on ServerException {
      return const Left(ServerFailure());
    }
  }
}
