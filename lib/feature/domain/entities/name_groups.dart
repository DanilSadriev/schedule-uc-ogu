import 'package:equatable/equatable.dart';

class NameGroups extends Equatable {
  final List<String> groups;
  final List<String> teachers;

  const NameGroups({
    required this.groups,
    required this.teachers,
  });

  @override
  List<Object?> get props => [groups, teachers];
}
