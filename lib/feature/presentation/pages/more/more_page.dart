import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raspisanie/feature/presentation/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:raspisanie/feature/presentation/bloc/schedule_bloc/schedule_state.dart';
import 'package:raspisanie/feature/presentation/widgets/buttons/setting_button.dart';
import '../../core/routes/routes.gr.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<Widget> list = [
    //   getContainer(),
    //   getContainer(),
    //   getContainer(),
    //   getContainer(),
    //   getContainer(),
    //   getContainer(),
    // ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Еще'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SettingButton(
              title: 'Настройки',
              onTap: () {
                context.router.push(const AppSettingsRoute());
              },
              enabled:
                  BlocProvider.of<ScheduleBloc>(context).state.runtimeType ==
                      ScheduleLoaded,
            ),
            SettingButton(
              title: 'О приложении',
              onTap: () {
                context.router.push(const AboutRoute());
              },
              enabled: true,
            ),
            SettingButton(
              title: 'Поддержка',
              onTap: () {
                context.router.push(const SupportRoute());
              },
              enabled: true,
            ),
          ],
        ),
      ),
    );
  }

  // Container getContainer() {
  //   return Container(
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(16.0),
  //         color: Colors.transparent,
  //         border: Border.all(
  //           color: DarkThemeColors.green,
  //           width: 2.0,
  //         )),
  //     width: 96,
  //     height: 96,
  //   );
  // }
}
