import 'package:dartz/dartz.dart';
import 'package:raspisanie/core/error/failure.dart';
import 'package:raspisanie/feature/domain/entities/added%20_groups.dart';

abstract class AddedGroupsRepository {
  Future<Either<Failure, AddedGroups>> getAllGroups(); //все значения
  Future<void> deleteGroup(Group group); //удаление
  Future<void> addGroup(Group group); // добавление
  Future<void> updateActiveGroup(Group group); //обновление активного значения
  Future<void> updateGroupName(Group group);
  Future<Either<Failure, Group>> getActiveGroup(); //возврат активного значения
}
