import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/usecases/usecase.dart';
import '../../entities/schedule_settings.dart';
import '../../repository/schedule_repository.dart';

class SetScheduleSettings extends UseCase<void, SetScheduleSettingsParams> {
  final ScheduleRepository scheduleRepository;

  SetScheduleSettings(this.scheduleRepository);

  @override
  Future<Either<Failure, void>> call(SetScheduleSettingsParams params) async {
    return Right(scheduleRepository.setSettings(params.settings));
  }
}

class SetScheduleSettingsParams extends Equatable {
  final ScheduleSettings settings;

  const SetScheduleSettingsParams(this.settings);

  @override
  List<Object?> get props => [settings];
}
