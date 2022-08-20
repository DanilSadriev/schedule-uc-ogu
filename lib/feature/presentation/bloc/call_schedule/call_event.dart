import 'package:equatable/equatable.dart';

// события расписания
abstract class CallEvent extends Equatable {
  const CallEvent();

  @override
  List<Object?> get props => [];
}

//показ расписания
class CallView extends CallEvent {
  final bool remote;
  const CallView(this.remote);
}
