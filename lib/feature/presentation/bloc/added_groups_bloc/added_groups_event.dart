import 'package:equatable/equatable.dart';
import 'package:raspisanie/feature/domain/entities/added%20_groups.dart';

// собития боковой панели
abstract class AddedGroupsEvent extends Equatable {
  const AddedGroupsEvent();

  @override
  List<Object?> get props => [];
}

// загрузилось
class LoadAddedGroups extends AddedGroupsEvent {}

// сохранение всех элементов
class SetAllAddedGroups extends AddedGroupsEvent {}

// добавление элемента
class AddGroupToAddedGroups extends AddedGroupsEvent {
  final Group group;

  const AddGroupToAddedGroups({required this.group});

  @override
  List<Object?> get props => [group];
}

// удаление элемента
class DeleteGroupToAddedGroups extends AddedGroupsEvent {
  const DeleteGroupToAddedGroups({required this.group});

  final Group group;

  @override
  List<Object?> get props => [group];
}

// обновление активного элемента
class UpdateActiveGroupAddedGroups extends AddedGroupsEvent {
  final Group group;

  const UpdateActiveGroupAddedGroups({required this.group});

  @override
  List<Object?> get props => [group];
}

// обновление имени элемента
class UpdateGroupNameAddedGroups extends AddedGroupsEvent {
  final Group group;

  const UpdateGroupNameAddedGroups({required this.group});

  @override
  List<Object?> get props => [group];
}

// возвращение выбранного элемента
class GetActiveGroupADdedGroups extends AddedGroupsEvent {
  final Group activeGroup;

  const GetActiveGroupADdedGroups({required this.activeGroup});

  @override
  List<Object?> get props => [activeGroup];
}
