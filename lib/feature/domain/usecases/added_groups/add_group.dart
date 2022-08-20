import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:raspisanie/core/error/failure.dart';
import 'package:raspisanie/core/error/usecases/usecase.dart';
import 'package:raspisanie/feature/domain/entities/added%20_groups.dart';
import 'package:raspisanie/feature/domain/repository/added_groups_repository.dart';

class AddGroup extends UseCase<void, AddGroupParams> {
  final AddedGroupsRepository addedGroupsRepository;

  AddGroup(this.addedGroupsRepository);

  @override
  Future<Either<Failure, void>> call(AddGroupParams params) async {
    return Right(addedGroupsRepository.addGroup(params.group));
  }
}

class AddGroupParams extends Equatable {
  final Group group;

  const AddGroupParams({required this.group});

  @override
  List<Object?> get props => [group];
}
