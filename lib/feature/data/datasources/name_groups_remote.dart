import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raspisanie/core/error/exception.dart';
import 'package:raspisanie/feature/data/models/name_groups_model.dart';

abstract class NameGroupsRemote {
  Future<NameGroupsModel> getGroups();
}

class NameGroupsRemoteImpl implements NameGroupsRemote {
  final CollectionReference data =
      FirebaseFirestore.instance.collection('data');

  @override
  Future<NameGroupsModel> getGroups() async {
    try {
      final groups =
          await data.doc('groups').get().then((value) => value.data());
      return NameGroupsModel.fromJson(groups as Map<String, dynamic>);
    } catch (e) {
      throw ServerException('$e');
    }
  }
}
