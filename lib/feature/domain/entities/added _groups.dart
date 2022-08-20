// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

class AddedGroups extends Equatable {
  final Group activeGroup; //активное значение
  final List<Group> allGroups; //все значения

  const AddedGroups({
    required this.activeGroup,
    required this.allGroups,
  });

  @override
  List<Object?> get props => [activeGroup, allGroups];
}

class Group {
  final String name;
  final String group;

  Group({required this.name, required this.group});
}
