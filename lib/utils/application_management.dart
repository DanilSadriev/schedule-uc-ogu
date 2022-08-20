import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationManagement {
  final SharedPreferences sharedPreferences;

  ApplicationManagement({required this.sharedPreferences});

  Future clearCashe() async {
    sharedPreferences.clear();
  }

  void restartApp() {
    Restart.restartApp();
  }

  Future<AdaptiveThemeMode> themeModeApp() async {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();

    if (savedThemeMode == null) {
      return AdaptiveThemeMode.system;
    } else {
      return savedThemeMode;
    }
  }
}
