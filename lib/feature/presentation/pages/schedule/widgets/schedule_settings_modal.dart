// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raspisanie/feature/domain/entities/added%20_groups.dart';
import 'package:raspisanie/feature/presentation/bloc/added_groups_bloc/added_groups_bloc.dart';
import 'package:raspisanie/feature/presentation/bloc/added_groups_bloc/added_groups_event.dart';
import 'package:raspisanie/feature/presentation/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:raspisanie/feature/presentation/bloc/schedule_bloc/schedule_event.dart';
import 'package:raspisanie/feature/presentation/pages/schedule/widgets/autocomplete_group_selector.dart';
import 'package:raspisanie/feature/presentation/pages/schedule/widgets/keyboard_positioned.dart';
import 'package:raspisanie/feature/presentation/pages/schedule/widgets/schedule_page_view.dart';
import 'package:raspisanie/feature/presentation/widgets/buttons/fill_button.dart';

// экран добавления новой группы или преподавателя
class ScheduleSettingsModal extends StatefulWidget {
  const ScheduleSettingsModal({Key? key, required this.isFirstRun})
      : super(key: key);

  final bool isFirstRun;

  @override
  _ScheduleSettingModal createState() => _ScheduleSettingModal();
}

class _ScheduleSettingModal extends State<ScheduleSettingsModal> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardPositioned(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).cardColor,
              Theme.of(context).backgroundColor
            ],
            begin: const Alignment(-1, -1),
            end: const Alignment(-1, 1),
          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Image(
                    image: AssetImage('assets/images/Saly-6.png'),
                    height: 250.0,
                  ),
                ),
                Text(
                  'Настройте расписание',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Text(
                  widget.isFirstRun
                      ? 'Кажется, что это ваш первый запуск. Установите группу или преподавателя, чтобы начать пользоваться расписанием'
                      : 'Установите группу или преподавателя, расписание которых вы хотите просматривать',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const AutocompleteGroupSelector(),
                const SizedBox(height: 32),
                ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                      width: double.infinity, height: 48),
                  child: FillButton(
                    onClick: () {
                      if (selectValue != '') {
                        Navigator.of(context).pop();
                        context.read<AddedGroupsBloc>().add(
                            AddGroupToAddedGroups(
                                group: Group(name: '', group: selectValue)));
                        context.read<AddedGroupsBloc>().add(LoadAddedGroups());
                        context
                            .read<ScheduleBloc>()
                            .add(ScheduleView(nowDate, selectValue));
                      }
                    },
                    text: 'Добавить',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
