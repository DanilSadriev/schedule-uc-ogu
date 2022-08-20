import 'package:equatable/equatable.dart';

abstract class NameGroupsState extends Equatable {
  const NameGroupsState();

  @override
  List<Object> get props => [];
}

class NameGroupsEmpty extends NameGroupsState {}

class NameGroupsLoading extends NameGroupsState {}

class NameGroupsLoaded extends NameGroupsState {
  final List<String> groups;
  final List<String> teachers;

  const NameGroupsLoaded({required this.groups, required this.teachers});

  @override
  List<Object> get props => [groups, teachers];
}

class NameGroupsError extends NameGroupsState {
  final String message;

  const NameGroupsError({required this.message});

  @override
  List<Object> get props => [message];
}
