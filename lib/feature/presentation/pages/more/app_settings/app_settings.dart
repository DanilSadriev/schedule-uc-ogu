import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raspisanie/feature/presentation/core/routes/routes.gr.dart';
import 'package:raspisanie/feature/presentation/widgets/rectangle_icon.dart';
import 'package:raspisanie/locator_service.dart';
import 'package:raspisanie/utils/application_management.dart';
import 'package:restart_app/restart_app.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../../../../common/theme/colors.dart';
import '../../../bloc/schedule_bloc/schedule_bloc.dart';
import '../../../bloc/schedule_bloc/schedule_event.dart';
import '../../../bloc/schedule_bloc/schedule_state.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({Key? key}) : super(key: key);

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  late bool initialValue;

  @override
  void initState() {
    super.initState();
    initialValue =
        (BlocProvider.of<ScheduleBloc>(context).state as ScheduleLoaded)
            .scheduleSettings
            .lectureBreaks;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: SettingsList(
        platform: DevicePlatform.iOS,
        darkTheme: const SettingsThemeData(
          settingsListBackground: DarkThemeColors.background,
          settingsSectionBackground: DarkThemeColors.lightGray,
        ),
        lightTheme: const SettingsThemeData(
          settingsListBackground: LightThemeColors.background,
          settingsSectionBackground: LightThemeColors.lightGray,
        ),
        brightness: Theme.of(context).brightness,
        sections: [
          SettingsSection(
            title: Text(
              'Расписание',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            tiles: [
              SettingsTile.navigation(
                title: Text(
                  'Карточка занятий',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                leading: const RectangleIcon(
                  icon: Icons.view_agenda,
                  color: DarkThemeColors.blue,
                ),
                onPressed: (context) {
                  context.router.push(const LessonCardSettings());
                },
              ),
              SettingsTile.switchTile(
                title: Text(
                  'Отображать перерывы',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                description: Text(
                  'При включении функции, после каждого занятия будет отображаться время перерыва.',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Theme.of(context).disabledColor),
                ),
                initialValue: initialValue,
                onToggle: (bool value) {
                  BlocProvider.of<ScheduleBloc>(context)
                      .add(ScheduleUpdateSettingsEvent(lectureBreaks: value));
                  setState(() {
                    initialValue = value;
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text(
              'Прочее',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            tiles: [
              SettingsTile(
                title: Text(
                  'Тема приложения',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                description: Text(
                  'По умолчанию установлена системная тема.',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Theme.of(context).disabledColor),
                ),
                trailing: Text(
                  Theme.of(context).brightness.name == 'light'
                      ? 'Светлая'
                      : 'Темная',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                onPressed: ((context) =>
                    AdaptiveTheme.of(context).toggleThemeMode()),
              ),
              SettingsTile(
                title: Text(
                  'Очистить кэш',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: DarkThemeColors.red),
                ),
                description: Text(
                  'После нажатия весь кэш приложения будет очищен. Приложение будет перезагружено.',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Theme.of(context).disabledColor),
                ),
                onPressed: (context) {
                  sl<ApplicationManagement>().clearCashe();
                  showDone();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Widget> showDone() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return const Icon(
          Icons.done,
          color: DarkThemeColors.green,
          size: 80.0,
        );
      },
    ).timeout(
      const Duration(seconds: 1),
      onTimeout: () {
        Restart.restartApp();
      },
    );
  }
}
