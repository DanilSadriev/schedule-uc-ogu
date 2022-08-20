import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:raspisanie/core/error/failure.dart';
import 'package:raspisanie/core/error/usecases/usecase.dart';
import 'package:raspisanie/feature/domain/entities/added%20_groups.dart';
import 'package:raspisanie/feature/domain/repository/added_groups_repository.dart';

class UpdateGroupName extends UseCase<void, UpdateGroupNameParams> {
  final AddedGroupsRepository addedGroupsRepository;

  UpdateGroupName(this.addedGroupsRepository);

  @override
  Future<Either<Failure, void>> call(UpdateGroupNameParams params) async {
    return Right(addedGroupsRepository.updateGroupName(params.group));
  }
}

class UpdateGroupNameParams extends Equatable {
  final Group group;

  const UpdateGroupNameParams({required this.group});

  @override
  List<Object?> get props => [group];
}
