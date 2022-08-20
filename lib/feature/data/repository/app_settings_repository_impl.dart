import 'package:raspisanie/core/error/exception.dart';
import 'package:raspisanie/feature/data/datasources/app_settings_local.dart';
import 'package:raspisanie/feature/data/models/app_settings_model.dart';
import 'package:raspisanie/feature/domain/entities/app_settings.dart';
import 'package:raspisanie/feature/domain/repository/app_settings_repository.dart';

// репозиторий настроек приложения
class AppSettingsRepositoryImpl implements AppSettingsRepository {
  final AppSettingsLocal localDataSource;

  AppSettingsRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<AppSettings> getSettings() async {
    try {
      final settings = await localDataSource.getSettingsFromCache();
      return settings;
    } on CacheException {
      const newLocalSettings = AppSettingsModel(
        onboardingShown: false,
      );
      await localDataSource.setSettingsToCache(newLocalSettings);
      return newLocalSettings;
    }
  }

  @override
  Future<void> setSettings(AppSettings settings) async {
    localDataSource.setSettingsToCache(
      AppSettingsModel(
        onboardingShown: settings.onboardingShown,
      ),
    );
  }
}
