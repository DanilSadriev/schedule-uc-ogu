import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:raspisanie/core/error/failure.dart';
import 'package:raspisanie/core/error/usecases/usecase.dart';
import 'package:raspisanie/feature/domain/entities/app_settings.dart';
import 'package:raspisanie/feature/domain/repository/app_settings_repository.dart';

class SetAppSettings extends UseCase<void, SetAppSettingsParams> {
  final AppSettingsRepository appSettingsRepository;

  SetAppSettings(this.appSettingsRepository);

  @override
  Future<Either<Failure, void>> call(SetAppSettingsParams params) async {
    return Right(appSettingsRepository.setSettings(params.settings));
  }
}

class SetAppSettingsParams extends Equatable {
  final AppSettings settings;

  const SetAppSettingsParams(this.settings);

  @override
  List<Object?> get props => [settings];
}
