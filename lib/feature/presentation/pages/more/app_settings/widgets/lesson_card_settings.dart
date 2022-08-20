import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raspisanie/common/theme/colors.dart';
import 'package:raspisanie/feature/domain/entities/lesson.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../../bloc/schedule_bloc/schedule_bloc.dart';
import '../../../../bloc/schedule_bloc/schedule_event.dart';
import '../../../../bloc/schedule_bloc/schedule_state.dart';

class LessonCardSettings extends StatefulWidget {
  const LessonCardSettings({Key? key}) : super(key: key);

  @override
  State<LessonCardSettings> createState() => _LessonCardSettingsState();
}

class _LessonCardSettingsState extends State<LessonCardSettings> {
  List<Lesson> lessons = const [
    Lesson(
      time: ['08:00', '09:35'],
      nomer: '1',
      name: 'Название пары',
      audience: '1125',
      groupOrTeacher: 'Название преподавателя',
    ),
    Lesson(
      time: ['09:45', '11:20'],
      nomer: '2',
      name: 'Название пары',
      audience: '1221',
      groupOrTeacher: 'Название преподавателя',
    ),
    Lesson(
      time: ['11:40', '13:15'],
      nomer: '3',
      name: 'Название пары',
      audience: '1301',
      groupOrTeacher: 'Название преподавателя',
    ),
    Lesson(
      time: ['13:25', '15:00'],
      nomer: '4',
      name: 'Название пары',
      audience: '1сз1',
      groupOrTeacher: 'Название преподавателя',
    ),
  ];

  late bool colored;
  late bool finishedLesson;

  @override
  void initState() {
    super.initState();
    colored = (BlocProvider.of<ScheduleBloc>(context).state as ScheduleLoaded)
        .scheduleSettings
        .colorfulLecture;
    finishedLesson =
        (BlocProvider.of<ScheduleBloc>(context).state as ScheduleLoaded)
            .scheduleSettings
            .finishedLecture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карточка занятий'),
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
        sections: [
          // CustomSettingsSection(
          //   child: Column(
          //     children: [
          //       LessonCard(
          //         lesson: lessons[0],
          //         colored: colored,
          //         finished: finishedLesson,
          //       ),
          //       LessonCard(
          //         lesson: lessons[1],
          //         colored: colored,
          //         finished: finishedLesson,
          //       ),
          //       LessonCard(
          //         lesson: lessons[2],
          //         colored: colored,
          //         finished: false,
          //       ),
          //       LessonCard(
          //         lesson: lessons[3],
          //         colored: colored,
          //         finished: false,
          //       ),
          //     ],
          //   ),
          // ),
          SettingsSection(
            tiles: [
              SettingsTile.switchTile(
                initialValue: colored,
                onToggle: ((value) {
                  BlocProvider.of<ScheduleBloc>(context)
                      .add(ScheduleUpdateSettingsEvent(colorfulLection: value));
                  setState(() {
                    colored = value;
                  });
                }),
                title: Text(
                  'Разные цвета для этажей',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                description: Text(
                  'В зависимости от этажа, подложка с номером аудитории, будет перекрашена в определенный цвет.',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Theme.of(context).disabledColor),
                ),
              ),
              SettingsTile.switchTile(
                initialValue: finishedLesson,
                onToggle: ((value) {
                  BlocProvider.of<ScheduleBloc>(context)
                      .add(ScheduleUpdateSettingsEvent(finishedLecture: value));
                  setState(() {
                    finishedLesson = value;
                  });
                }),
                title: Text(
                  'Отображать состояние занятия\n(в разработке)',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                description: Text(
                  'Если занятие уже прошло, то карточка с лекцией будет затемнена. Пройденные занятия отмечаются только в действующий день.',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Theme.of(context).disabledColor),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  SwitchListTile swithItem({
    required Function function,
    required bool variable,
    required String title,
    String? subtitle,
  }) {
    return SwitchListTile(
      isThreeLine: subtitle == null ? false : true,
      activeColor: DarkThemeColors.white,
      activeTrackColor: DarkThemeColors.green,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: DarkThemeColors.gray),
            ),
      onChanged: (bool value) {
        function();
      },
      value: variable,
    );
  }
}
