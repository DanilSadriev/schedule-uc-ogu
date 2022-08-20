import 'package:equatable/equatable.dart';

///Модель пары в расписании
class Lesson extends Equatable {
  final List<String> time; //время пары
  final String nomer; //номер пары
  final String name; //название пары
  final String audience; //аудитория
  final String groupOrTeacher; //название группы или ФИО препод.

  //конструктор
  const Lesson({
    required this.time,
    required this.nomer,
    required this.name,
    required this.audience,
    required this.groupOrTeacher,
  });

  //геттер
  @override
  List<Object?> get props => [time, nomer, name, audience, groupOrTeacher];
}
