import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raspisanie/feature/presentation/widgets/buttons/fill_button.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../../../../../common/theme/colors.dart';
import '../../../../bloc/schedule_bloc/schedule_bloc.dart';
import '../../../../bloc/schedule_bloc/schedule_event.dart';
import '../../../../bloc/schedule_bloc/schedule_state.dart';

class SelectFormatCalendarPage extends StatefulWidget {
  const SelectFormatCalendarPage({Key? key}) : super(key: key);

  @override
  State<SelectFormatCalendarPage> createState() =>
      _SelectFormatCalendarPageState();
}

class _SelectFormatCalendarPageState extends State<SelectFormatCalendarPage> {
  int calendarFormatValue = 2;
  late int defaultCalendarFormat;
  List<String> calendarFormatList = ['Месяц', '2 недели', 'Неделя'];

  @override
  void initState() {
    defaultCalendarFormat =
        (BlocProvider.of<ScheduleBloc>(context).state as ScheduleLoaded)
            .scheduleSettings
            .calendarFormat;
    calendarFormatValue = defaultCalendarFormat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Формат календаря'),
      ),
      body: SettingsList(
        platform: DevicePlatform.iOS,
        darkTheme: const SettingsThemeData(
          settingsListBackground: DarkThemeColors.background,
        ),
        sections: [
          SettingsSection(
            tiles: [
              buildTile(0),
              buildTile(1),
              buildTile(2),
            ],
          ),
          SettingsSection(
            tiles: [
              CustomSettingsTile(
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                      width: double.infinity, height: 48),
                  child: FillButton(
                    onClick: () async {
                      if (defaultCalendarFormat != calendarFormatValue) {
                        await save();
                      }
                    },
                    text: 'Применить изменения',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SettingsTile buildTile(int index) {
    return SettingsTile(
      leading:
          calendarFormatList[index] == calendarFormatList[calendarFormatValue]
              ? const Icon(
                  Icons.done,
                  color: DarkThemeColors.blue,
                )
              : const SizedBox(width: 24.0),
      title: Text(
        calendarFormatList[index],
        style: Theme.of(context)
            .textTheme
            .button
            ?.copyWith(color: DarkThemeColors.white),
      ),
      description: index == 2
          ? Text(
              'После применения настроек, приложение будет перезагружено.',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: DarkThemeColors.gray),
            )
          : null,
      onPressed: ((context) {
        setState(() {
          if (index != calendarFormatValue) {
            calendarFormatValue = index;
          }
        });
      }),
    );
  }

  Future save() async {
    BlocProvider.of<ScheduleBloc>(context)
        .add(ScheduleUpdateSettingsEvent(calendarFormat: calendarFormatValue));
  }
}
