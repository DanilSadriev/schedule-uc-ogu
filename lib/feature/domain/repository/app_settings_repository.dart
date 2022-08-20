import 'package:raspisanie/feature/domain/entities/app_settings.dart';

abstract class AppSettingsRepository {
  Future<AppSettings> getSettings(); //возврат всех настроек
  Future<void> setSettings(AppSettings settings); //запись всех настроек
}
