import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:raspisanie/core/error/failure.dart';
import 'package:raspisanie/core/error/usecases/usecase.dart';
import 'package:raspisanie/feature/domain/entities/added%20_groups.dart';
import 'package:raspisanie/feature/domain/repository/added_groups_repository.dart';

class UpdateActiveGroup extends UseCase<void, UpdateActiveGroupParams> {
  final AddedGroupsRepository addedGroupsRepository;

  UpdateActiveGroup(this.addedGroupsRepository);

  @override
  Future<Either<Failure, void>> call(UpdateActiveGroupParams params) async {
    return Right(addedGroupsRepository.updateActiveGroup(params.group));
  }
}

class UpdateActiveGroupParams extends Equatable {
  final Group group;

  const UpdateActiveGroupParams({required this.group});

  @override
  List<Object?> get props => [group];
}
