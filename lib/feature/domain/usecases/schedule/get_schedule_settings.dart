import '../../../../core/error/usecases/usecase.dart';
import '../../entities/schedule_settings.dart';
import '../../repository/schedule_repository.dart';

class GetScheduleSettings extends UseCaseRight<ScheduleSettings, void> {
  final ScheduleRepository scheduleRepository;

  GetScheduleSettings(this.scheduleRepository);

  @override
  Future<ScheduleSettings> call([params]) async {
    return await scheduleRepository.getSettings();
  }
}
