// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raspisanie/feature/domain/usecases/schedule/get_all_schedule.dart';
import 'package:raspisanie/feature/presentation/bloc/schedule_bloc/schedule_event.dart';
import 'package:raspisanie/feature/presentation/bloc/schedule_bloc/schedule_state.dart';

import '../../../../utils/failure_utils.dart';
import '../../../domain/entities/schedule_settings.dart';
import '../../../domain/usecases/schedule/get_schedule_settings.dart';
import '../../../domain/usecases/schedule/set_schedule_settings.dart';

// Bloc расписания
class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final GetAllSchedule getAllSchedule;
  final GetScheduleSettings getScheduleSettings;
  final SetScheduleSettings setScheduleSettings;
  ScheduleBloc(
      {required this.getScheduleSettings,
      required this.setScheduleSettings,
      required this.getAllSchedule})
      : super(ScheduleEmpty()) {
    on<ScheduleView>(_onEvent);
    on<ScheduleUpdateSettingsEvent>(_onScheduleUpdateSettingsEvent);
  }

  // получение расписания
  FutureOr<void> _onEvent(
      ScheduleView event, Emitter<ScheduleState> emit) async {
    emit(ScheduleLoading());
    final failureOrSchedule = await getAllSchedule(
        ScheduleParams(date: event.date, group: event.group ?? ''));
    final scheduleSettings = await getScheduleSettings();

    emit(failureOrSchedule.fold(
        (failure) => ScheduleError(
              message: FailureUtils().mapFailureToMessage(failure),
            ),
        (schedule) => ScheduleLoaded(schedule, scheduleSettings)));
  }

  void _onScheduleUpdateSettingsEvent(
    ScheduleUpdateSettingsEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    final oldSettings = await getScheduleSettings();
    final newSettings = ScheduleSettings(
      lectureBreaks: event.lectureBreaks ?? oldSettings.lectureBreaks,
      colorfulLecture: event.colorfulLection ?? oldSettings.colorfulLecture,
      finishedLecture: event.finishedLecture ?? oldSettings.finishedLecture,
      calendarFormat: event.calendarFormat ?? oldSettings.calendarFormat,
    );

    await setScheduleSettings(SetScheduleSettingsParams(newSettings));

    if (state is ScheduleLoaded) {
      final currentState = state as ScheduleLoaded;
      emit(ScheduleLoaded(
        currentState.schedules,
        newSettings,
      ));
    }
  }
}
