import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:raspisanie/feature/domain/entities/call_schedule.dart';
import 'package:raspisanie/feature/domain/usecases/call_schedule/get_call_schedule.dart';
import 'package:raspisanie/utils/failure_utils.dart';

import 'call_event.dart';
import 'call_state.dart';

late CallSchedule callSchedule;

class CallBloc extends Bloc<CallEvent, CallState> {
  final GetCallSchedule getCallSchedule;

  CallBloc({required this.getCallSchedule}) : super(CallEmpty()) {
    on<CallView>(_onEvent);
  }

  FutureOr<void> _onEvent(CallView event, Emitter<CallState> emit) async {
    emit(CallLoading());
    final failureOrCalls =
        await getCallSchedule(GetCallScheduleParams(event.remote));

    emit(
      failureOrCalls.fold(
        (failure) =>
            CallError(message: FailureUtils().mapFailureToMessage(failure)),
        (calls) {
          callSchedule = calls;
          return CallLoaded(calls);
        },
      ),
    );
  }
}
