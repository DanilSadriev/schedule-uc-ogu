import 'package:equatable/equatable.dart';

///Модель расписания звонков
class CallSchedule extends Equatable {
  final Map<String, List<String>> callWorkDays;
  final Map<String, List<String>> callSaturday;
  final Map<String, List<String>> callAbreviated;

  //конструктор
  const CallSchedule({
    required this.callWorkDays,
    required this.callSaturday,
    required this.callAbreviated,
  });

  //геттер
  @override
  List<Object?> get props => [
        callWorkDays,
        callSaturday,
        callAbreviated,
      ];
}
