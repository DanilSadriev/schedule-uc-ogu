import 'package:dartz/dartz.dart';
import 'package:raspisanie/feature/domain/entities/name_groups.dart';
import 'package:raspisanie/feature/domain/repository/name_groups_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/usecases/usecase.dart';

class GetGroups extends UseCase<NameGroups, void> {
  final NameGroupsRepository nameGroupsRepository;

  GetGroups(this.nameGroupsRepository);

  @override
  Future<Either<Failure, NameGroups>> call([params]) async {
    return await nameGroupsRepository.getGroups();
  }
}
