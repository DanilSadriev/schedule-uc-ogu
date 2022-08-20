import 'dart:convert';
import 'package:raspisanie/core/error/exception.dart';
import 'package:raspisanie/feature/data/models/added_groups_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// получение активных групп с кеша
abstract class AddedGroupsLocal {
  /// Gets the cached [List<String>] names of all available value for
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<AddedGroupsModel> getAllGroupsFromCache();

  Future<void> setAllGroupsToCache(AddedGroupsModel addedGroups);
}

class AddedGroupsLocalImpl implements AddedGroupsLocal {
  final SharedPreferences sharedPreferences;

  AddedGroupsLocalImpl({required this.sharedPreferences});

  @override
  Future<void> setAllGroupsToCache(AddedGroupsModel addedGroups) async {
    final String newValue = json.encode(addedGroups.toJson());
    sharedPreferences.setString('added_groups', newValue);
  }

  @override
  Future<AddedGroupsModel> getAllGroupsFromCache() async {
    final value = sharedPreferences.getString('added_groups');
    print('getAllGroupsFromCache: $value');
    if (value != null) {
      return Future.value(AddedGroupsModel.fromJson(json.decode(value)));
    }
    return AddedGroupsModel(
        activeGroup: GroupModel(name: '', group: ''), allGroups: const []);
  }
}
