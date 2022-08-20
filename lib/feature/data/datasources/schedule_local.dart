import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exception.dart';
import '../models/schedule_settings_model.dart';

abstract class ScheduleLocalData {
  Future<void> setSettingsToCache(ScheduleSettingsModel settings);
  Future<ScheduleSettingsModel> getSettingsFromCache();
}

class ScheduleLocalDataImpl implements ScheduleLocalData {
  final SharedPreferences sharedPreferences;

  ScheduleLocalDataImpl({required this.sharedPreferences});

  @override
  Future<ScheduleSettingsModel> getSettingsFromCache() {
    String? settings = sharedPreferences.getString('schedule_settings');
    if (settings == null) throw CacheException('The settings are not set');
    return Future.value(ScheduleSettingsModel.fromRawJson(settings));
  }

  @override
  Future<void> setSettingsToCache(ScheduleSettingsModel settings) {
    return sharedPreferences.setString(
        'schedule_settings', settings.toRawJson());
  }
}
