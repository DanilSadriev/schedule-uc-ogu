import 'package:raspisanie/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:raspisanie/core/error/usecases/usecase.dart';
import 'package:raspisanie/feature/domain/entities/added%20_groups.dart';
import 'package:raspisanie/feature/domain/repository/added_groups_repository.dart';

class GetAllGroups extends UseCase<AddedGroups, void> {
  final AddedGroupsRepository addedGroupsRepository;

  GetAllGroups(this.addedGroupsRepository);

  @override
  Future<Either<Failure, AddedGroups>> call([params]) async {
    return await addedGroupsRepository.getAllGroups();
  }
}
