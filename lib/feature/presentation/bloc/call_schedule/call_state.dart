import 'package:equatable/equatable.dart';
import 'package:raspisanie/feature/domain/entities/call_schedule.dart';

abstract class CallState extends Equatable {
  const CallState();

  @override
  List<Object?> get props => [];
}

//ещё ничего не загрузилось
class CallEmpty extends CallState {}

//загружается
class CallLoading extends CallState {}

//загрузилось
class CallLoaded extends CallState {
  final CallSchedule calls;

  const CallLoaded(this.calls);

  @override
  List<Object?> get props => [calls];
}

//ошибка
class CallError extends CallState {
  final String message;

  const CallError({required this.message});

  @override
  List<Object?> get props => [message];
}
