// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:raspisanie/core/error/exception.dart';
import 'package:raspisanie/feature/data/models/schedule_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' show DateFormat;
import 'package:raspisanie/feature/presentation/bloc/call_schedule/call_bloc.dart';

// получение расписания с сервера
abstract class ScheduleRemoteDataSource {
  /// Calls the https://www.uc.osu.ru/generate_data.php endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ScheduleModel>> getAllSchedule(DateTime date, String group);
  // Future<List<String>> getGroups();
}

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final http.Client client;
  String type = '';
  ScheduleRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ScheduleModel>> getAllSchedule(
      DateTime dateTime, String group) async {
    final String date = DateFormat('dd-MM-yyyy').format(dateTime);

    //проверка на наличие расписания в дате
    try {
      if (!await _chek(date)) {
        return []
            .map((emptySchedule) => ScheduleModel.fromJson(emptySchedule))
            .toList();
      }
    } catch (e) {
      throw ServerException(e.toString());
    }

    //получение Id выбранной группы или преподавателя
    String id = await _getId(date, group);

    //если Id пустое то возвращаем пустую пару
    if (id == '') {
      return [].map((para) => ScheduleModel.fromJson(para)).toList();
    }

    //Получение расписания для группы или преподавателя в выбранную дату
    final response = await http.post(
        Uri.parse('https://www.uc.osu.ru/generate_data.php'),
        body: {'type': type, 'data': date, 'id': id});

    if (response.statusCode == 200) {
      List<String> scheduleElements = [];
      var raspHtml = parse(response.body);

      //извлекаем из Html строки с текстом
      var rows =
          raspHtml.getElementsByTagName('table')[0].getElementsByTagName('td');
      rows
          .map((Element elementHtml) => elementHtml.innerHtml)
          .forEach((String element) {
        scheduleElements.add(element);
      });

      //удаляем первые 2 значения если тип = 1 (группа)
      if (type == '1') {
        scheduleElements.removeRange(0, 2);
      } else {}

      List<Map<String, dynamic>> schedule = [];
      Map<String, dynamic> lesson = {};
      List<String> classTime = [];
      for (int i = 0; i < scheduleElements.length; i += 4) {
        lesson = {};
        classTime = [];

        if (dateTime.weekday == 6) {
          classTime = [...?callSchedule.callSaturday[scheduleElements[i]]];
        } else {
          classTime = [...?callSchedule.callWorkDays[scheduleElements[i]]];
        }
        lesson['time'] = classTime;
        lesson['nomer'] = scheduleElements[i];
        lesson['name'] = scheduleElements[i + 1];
        lesson['audience'] = scheduleElements[i + 2];
        lesson['groupOrTeacher'] = scheduleElements[i + 3];
        schedule.add(lesson);
      }
      return (schedule)
          .map((mapSchedule) => ScheduleModel.fromJson(mapSchedule))
          .toList();
    } else {
      throw ServerException('Response status code is ${response.statusCode}');
    }
  }

  Future<String> _getId(String date, String group) async {
    final symbols = RegExp(r'[0-9-]');
    if (symbols.hasMatch(group)) {
      type = '1';
    } else {
      type = '2';
    }

    String id = '';

    //определение Id студента или преподователя
    final response = await http.post(
        Uri.parse('https://www.uc.osu.ru/back_parametr.php'),
        body: {'type_id': type, 'data': date});

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonId = await json.decode(response.body);
      for (var i in jsonId.keys) {
        if (group == jsonId[i]) {
          id = i;
          break;
        }
      }
      return id;
    } else {
      throw ServerException('Response status code is ${response.statusCode}');
    }
  }

  Future<bool> _chek(String date) async {
    final response = await http.post(
        Uri.parse('https://www.uc.osu.ru/chek_file.php'),
        body: {'data': date});

    if (response.statusCode == 200) {
      if (response.body == 'err') {
        return false;
      } else {
        return true;
      }
    } else {
      throw ServerException('Response status code is ${response.statusCode}');
    }
  }
}
