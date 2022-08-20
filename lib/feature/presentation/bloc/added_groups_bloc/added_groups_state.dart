import 'package:equatable/equatable.dart';
import 'package:raspisanie/feature/domain/entities/added%20_groups.dart';

// состояния бокового меню
abstract class AddedGroupsState extends Equatable {
  const AddedGroupsState();

  @override
  List<Object?> get props => [];
}

//не загрузилось ещё
class AddedGroupsEmpty extends AddedGroupsState {}

//загружается
class AddedGroupsLoading extends AddedGroupsState {}

//загрузилось
class AddedGroupsLoaded extends AddedGroupsState {
  final List<Group> groups;
  final Group activeGroup;

  const AddedGroupsLoaded({required this.groups, required this.activeGroup});

  @override
  List<Object?> get props => [groups, activeGroup];
}

class AddedGroupsNotItems extends AddedGroupsState {}

//ошибка
class AddedGroupsError extends AddedGroupsState {
  final String message;

  const AddedGroupsError({required this.message});

  @override
  List<Object?> get props => [message];
}
