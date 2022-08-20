import 'package:raspisanie/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:raspisanie/core/error/usecases/usecase.dart';
import 'package:raspisanie/feature/domain/repository/added_groups_repository.dart';

import '../../entities/added _groups.dart';

class GetActiveGroup extends UseCase<Group, void> {
  final AddedGroupsRepository addedGroupsRepository;

  GetActiveGroup(this.addedGroupsRepository);

  @override
  Future<Either<Failure, Group>> call([params]) async {
    return await addedGroupsRepository.getActiveGroup();
  }
}
