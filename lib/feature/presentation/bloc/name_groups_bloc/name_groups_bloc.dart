import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:raspisanie/feature/domain/usecases/name_groups/get_groups.dart';
import 'package:raspisanie/feature/presentation/bloc/name_groups_bloc/name_groups_event.dart';
import 'package:raspisanie/utils/failure_utils.dart';

import 'name_groups_state.dart';

class NameGroupsBloc extends Bloc<NameGroupsEvent, NameGroupsState> {
  final GetGroups getGroups;

  NameGroupsBloc({required this.getGroups}) : super(NameGroupsEmpty()) {
    on<GetNameGroups>(_getNameGroups);
  }

  FutureOr<void> _getNameGroups(
      GetNameGroups event, Emitter<NameGroupsState> emit) async {
    emit(NameGroupsLoading());

    final failureOrGroups = await getGroups();

    emit(failureOrGroups.fold(
        (failure) => NameGroupsError(
            message: FailureUtils().mapFailureToMessage(failure)),
        (groups) => NameGroupsLoaded(
            groups: groups.groups, teachers: groups.teachers)));
  }
}
