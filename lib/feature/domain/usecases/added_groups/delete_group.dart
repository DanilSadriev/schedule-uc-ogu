import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:raspisanie/core/error/failure.dart';
import 'package:raspisanie/core/error/usecases/usecase.dart';
import 'package:raspisanie/feature/domain/entities/added%20_groups.dart';
import 'package:raspisanie/feature/domain/repository/added_groups_repository.dart';

class DeleteGroup extends UseCase<void, DeleteGroupParams> {
  final AddedGroupsRepository addedGroupsRepository;

  DeleteGroup(this.addedGroupsRepository);

  @override
  Future<Either<Failure, void>> call(DeleteGroupParams params) async {
    return Right(addedGroupsRepository.deleteGroup(params.group));
  }
}

class DeleteGroupParams extends Equatable {
  final Group group;

  const DeleteGroupParams({required this.group});

  @override
  List<Object?> get props => [group];
}
