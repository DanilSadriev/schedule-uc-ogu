import 'package:raspisanie/core/error/exception.dart';
import 'package:raspisanie/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:raspisanie/feature/data/datasources/added_groups.local.dart';
import 'package:raspisanie/feature/data/models/added_groups_model.dart';
import 'package:raspisanie/feature/domain/entities/added%20_groups.dart';
import 'package:raspisanie/feature/domain/repository/added_groups_repository.dart';

// репозиторий выбранных групп и преподователей
class AddedGroupsRepositoryImpl implements AddedGroupsRepository {
  final AddedGroupsLocal addedGroupsLocal;

  AddedGroupsRepositoryImpl({required this.addedGroupsLocal});

  @override
  Future<void> deleteGroup(Group group) async {
    try {
      final addedGroups = await addedGroupsLocal.getAllGroupsFromCache();

      Group activeGroup = Group(
          name: addedGroups.activeGroup.name,
          group: addedGroups.activeGroup.group);
      List<Group> allGroups = [];

      for (int i = 0; i < addedGroups.allGroups.length; i++) {
        // update schedule
        if (addedGroups.allGroups[i].group != group.group) {
          allGroups.add(addedGroups.allGroups[i]);
        }
      }

      if (addedGroups.activeGroup == group) {
        if (group.group.isNotEmpty) {
          activeGroup =
              Group(name: allGroups.first.name, group: allGroups.first.group);
        }
      }

      addedGroupsLocal.setAllGroupsToCache(
          AddedGroupsModel(activeGroup: activeGroup, allGroups: allGroups));
    } on CacheException {
      return;
    }
  }

  @override
  Future<Either<Failure, AddedGroups>> getAllGroups() async {
    try {
      final addedGroups = await addedGroupsLocal.getAllGroupsFromCache();

      print('allAddedGroups: ${addedGroups.allGroups}');

      return Right(addedGroups);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<void> addGroup(Group group) async {
    final oldAddedGroups = await addedGroupsLocal.getAllGroupsFromCache();
    List<Group> allGroups = [];
    GroupModel activeGroup = GroupModel(name: group.name, group: group.group);

    print('addGroup: ${group.group}');

    if (oldAddedGroups.allGroups.isEmpty) {
      allGroups.add(GroupModel(name: group.name, group: group.group));
      addedGroupsLocal.setAllGroupsToCache(AddedGroupsModel(
          activeGroup:
              GroupModel(name: activeGroup.name, group: activeGroup.group),
          allGroups: allGroups));
    } else {
      bool isExists = false;
      for (int i = 0; i < oldAddedGroups.allGroups.length; i++) {
        if (oldAddedGroups.allGroups[i].group == group.group) {
          isExists = true;
          break;
        }
      }
      if (!isExists) {
        allGroups.addAll(oldAddedGroups.allGroups);
        allGroups.add(GroupModel(name: group.name, group: group.group));

        addedGroupsLocal.setAllGroupsToCache(AddedGroupsModel(
            activeGroup:
                GroupModel(name: activeGroup.name, group: activeGroup.group),
            allGroups: allGroups));
      }
    }
  }

  @override
  Future<void> updateActiveGroup(Group group) async {
    final oldAddedGroups = await addedGroupsLocal.getAllGroupsFromCache();
    Group activeValue = Group(name: '', group: '');

    for (int i = 0; i < oldAddedGroups.allGroups.length; i++) {
      if (oldAddedGroups.allGroups[i].group == group.group) {
        activeValue = Group(name: group.name, group: group.group);
      }
    }

    addedGroupsLocal.setAllGroupsToCache(AddedGroupsModel(
        activeGroup: activeValue, allGroups: oldAddedGroups.allGroups));
  }

  @override
  Future<Either<Failure, Group>> getActiveGroup() async {
    try {
      final addedGroups = await addedGroupsLocal.getAllGroupsFromCache();
      return Right(addedGroups.activeGroup);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<void> updateGroupName(Group group) async {
    final oldAddedGroups = await addedGroupsLocal.getAllGroupsFromCache();
    Group activeGroup = Group(
        name: oldAddedGroups.activeGroup.name,
        group: oldAddedGroups.activeGroup.group);
    List<Group> allGroups = [];

    if (oldAddedGroups.activeGroup.group == group.group) {
      activeGroup = Group(name: group.name, group: group.group);
    }

    for (int i = 0; i < oldAddedGroups.allGroups.length; i++) {
      if (oldAddedGroups.allGroups[i].group == group.group) {
        allGroups.add(
          Group(name: group.name, group: group.group),
        );
      } else {
        allGroups.add(oldAddedGroups.allGroups[i]);
      }
    }

    addedGroupsLocal.setAllGroupsToCache(
        AddedGroupsModel(activeGroup: activeGroup, allGroups: allGroups));
  }
}
