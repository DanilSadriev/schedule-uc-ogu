// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raspisanie/feature/data/models/call_schedule_model.dart';

import '../../../core/error/exception.dart';

abstract class CallScheduleRemoteDataSource {
  Future<CallScheduleModel> getCallSchedule();
}

class CallScheduleRemoteDataSourceImpl implements CallScheduleRemoteDataSource {
  final CollectionReference data =
      FirebaseFirestore.instance.collection('data');

  @override
  Future<CallScheduleModel> getCallSchedule() async {
    try {
      final calls = await data.doc('calls').get().then((value) => value.data());

      CallScheduleModel callSchedule =
          CallScheduleModel.fromJson(calls as Map<String, dynamic>);
      return callSchedule;
    } catch (e) {
      throw ServerException('$e');
    }
  }
}
