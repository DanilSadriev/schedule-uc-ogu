import 'package:raspisanie/feature/domain/entities/added%20_groups.dart';

// модель активных групп
class AddedGroupsModel extends AddedGroups {
  const AddedGroupsModel({
    required Group activeGroup,
    required List<Group> allGroups,
  }) : super(
          activeGroup: activeGroup,
          allGroups: allGroups,
        );

  factory AddedGroupsModel.fromJson(Map<String, dynamic> json) {
    return AddedGroupsModel(
      activeGroup: GroupModel.fromJson(json['active_group']),
      allGroups: List<GroupModel>.from(
          json['all_groups'].map((x) => GroupModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'active_group':
          GroupModel(name: activeGroup.name, group: activeGroup.group).toJson(),
      'all_groups': List<dynamic>.from(allGroups
          .map((e) => (GroupModel(name: e.name, group: e.group)).toJson())),
    };
  }
}

class GroupModel extends Group {
  GroupModel({required String name, required String group})
      : super(name: name, group: group);

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        name: json['name'],
        group: json['group'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'group': group,
      };
}
