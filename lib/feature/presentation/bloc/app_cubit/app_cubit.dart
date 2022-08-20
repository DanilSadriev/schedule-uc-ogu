import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raspisanie/feature/domain/entities/app_settings.dart';
import 'package:raspisanie/feature/domain/usecases/app_settings/get_app_settings.dart';
import 'package:raspisanie/feature/domain/usecases/app_settings/set_app_settings.dart';
// import 'package:raspisanie/services/auth.dart';

part 'app_state.dart';

// Cubit настроек приложения
class AppCubit extends Cubit<AppState> {
  final GetAppSettings getAppSettings;
  final SetAppSettings setAppSettings;

  AppCubit({required this.getAppSettings, required this.setAppSettings})
      : super(AppInitial());

  void checkOnboarding() async {
    final settings = await getAppSettings();

    if (settings.onboardingShown == false) {
      emit(AppOnboarding());
      await setAppSettings(
        const SetAppSettingsParams(
          AppSettings(
            onboardingShown: true,
          ),
        ),
      );
    } else {
      closeOnboarding();
    }
  }

  void closeOnboarding() => emit(AppClean());
}
