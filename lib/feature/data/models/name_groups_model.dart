import 'package:raspisanie/feature/domain/entities/name_groups.dart';

class NameGroupsModel extends NameGroups {
  const NameGroupsModel({
    required List<String> groups,
    required List<String> teachers,
  }) : super(
          groups: groups,
          teachers: teachers,
        );

  factory NameGroupsModel.fromJson(Map<String, dynamic> json) {
    return NameGroupsModel(
      groups: List<String>.from(json['groups']),
      teachers: List<String>.from(json['teachers']),
    );
  }
}
