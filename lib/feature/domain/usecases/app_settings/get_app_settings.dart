import 'package:raspisanie/core/error/usecases/usecase.dart';
import 'package:raspisanie/feature/domain/entities/app_settings.dart';
import 'package:raspisanie/feature/domain/repository/app_settings_repository.dart';

class GetAppSettings extends UseCaseRight<AppSettings, void> {
  final AppSettingsRepository appSettingsRepository;

  GetAppSettings(this.appSettingsRepository);

  @override
  Future<AppSettings> call([params]) async {
    return await appSettingsRepository.getSettings();
  }
}
