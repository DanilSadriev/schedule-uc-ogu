import 'package:equatable/equatable.dart';

abstract class NameGroupsEvent extends Equatable {
  const NameGroupsEvent();

  @override
  List<Object?> get props => [];
}

class GetNameGroups extends NameGroupsEvent {}
