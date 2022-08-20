import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raspisanie/feature/domain/usecases/added_groups/add_group.dart';
import 'package:raspisanie/feature/domain/usecases/added_groups/delete_group.dart';
import 'package:raspisanie/feature/domain/usecases/added_groups/get_all_groups.dart';
import 'package:raspisanie/feature/domain/usecases/added_groups/update_active_group.dart';
import 'package:raspisanie/feature/domain/usecases/added_groups/update_group_name.dart';

import '../../../../utils/failure_utils.dart';
import 'added_groups_event.dart';
import 'added_groups_state.dart';

// Bloc боковой панели(активные группы и преподователи)
class AddedGroupsBloc extends Bloc<AddedGroupsEvent, AddedGroupsState> {
  final GetAllGroups getAllGroups;
  final DeleteGroup deleteGroup;
  final AddGroup addGroup;
  final UpdateActiveGroup updateActiveGroup;
  final UpdateGroupName updateGroupName;

  AddedGroupsBloc({
    required this.getAllGroups,
    required this.deleteGroup,
    required this.addGroup,
    required this.updateActiveGroup,
    required this.updateGroupName,
  }) : super(AddedGroupsEmpty()) {
    on<LoadAddedGroups>(_getAllGroups);
    on<UpdateActiveGroupAddedGroups>(_updateActiveGroup);
    on<UpdateGroupNameAddedGroups>(_updateGroupName);
    on<DeleteGroupToAddedGroups>(_deleteGroup);
    on<AddGroupToAddedGroups>(_addGroup);
  }

  // возвращение всех активных элементов
  FutureOr<void> _getAllGroups(
    AddedGroupsEvent event,
    Emitter<AddedGroupsState> emit,
  ) async {
    emit(AddedGroupsLoading());

    final addedGroups = await getAllGroups();

    emit(
      addedGroups.fold(
        (failure) => AddedGroupsError(
            message: FailureUtils().mapFailureToMessage(failure)),
        (groups) {
          if (groups.allGroups.isNotEmpty) {
            return AddedGroupsLoaded(
                groups: groups.allGroups, activeGroup: groups.activeGroup);
          } else {
            return AddedGroupsNotItems();
          }
        },
      ),
    );
  }

  // добавление элемента
  FutureOr<void> _addGroup(
    AddGroupToAddedGroups event,
    Emitter<AddedGroupsState> emit,
  ) async {
    emit(AddedGroupsLoading());

    await addGroup(AddGroupParams(group: event.group));

    final addedGroups = await getAllGroups();

    emit(addedGroups.fold(
        (failure) => AddedGroupsError(
            message: FailureUtils().mapFailureToMessage(failure)), (groups) {
      return AddedGroupsLoaded(
          groups: groups.allGroups, activeGroup: groups.activeGroup);
    }));
  }

  // удаление элемента
  FutureOr<void> _deleteGroup(
    DeleteGroupToAddedGroups event,
    Emitter<AddedGroupsState> emit,
  ) async {
    emit(AddedGroupsLoading());

    await deleteGroup(DeleteGroupParams(group: event.group));
    final addedGroups = await getAllGroups();
    emit(addedGroups.fold(
        (failure) => AddedGroupsError(
            message: FailureUtils().mapFailureToMessage(failure)),
        (groups) => AddedGroupsLoaded(
            groups: groups.allGroups, activeGroup: groups.activeGroup)));
  }

  // обновление элемента
  FutureOr<void> _updateActiveGroup(
    UpdateActiveGroupAddedGroups event,
    Emitter<AddedGroupsState> emit,
  ) async {
    emit(AddedGroupsLoading());

    await updateActiveGroup(UpdateActiveGroupParams(group: event.group));

    final addedGroups = await getAllGroups();

    emit(addedGroups.fold(
        (failure) => AddedGroupsError(
            message: FailureUtils().mapFailureToMessage(failure)),
        (groups) => AddedGroupsLoaded(
            groups: groups.allGroups, activeGroup: groups.activeGroup)));
  }

  FutureOr<void> _updateGroupName(
    UpdateGroupNameAddedGroups event,
    Emitter<AddedGroupsState> emit,
  ) async {
    emit(AddedGroupsLoading());

    await updateGroupName(UpdateGroupNameParams(group: event.group));

    final addedGroups = await getAllGroups();

    emit(addedGroups.fold(
        (failure) => AddedGroupsError(
            message: FailureUtils().mapFailureToMessage(failure)),
        (groups) => AddedGroupsLoaded(
            groups: groups.allGroups, activeGroup: groups.activeGroup)));
  }
}
