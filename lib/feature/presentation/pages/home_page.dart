import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raspisanie/feature/presentation/bloc/app_cubit/app_cubit.dart';
import 'package:raspisanie/feature/presentation/core/routes/routes.gr.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(builder: (context, state) {
      // определение требуемости показа onboarding
      context.read<AppCubit>().checkOnboarding();

      if (state is AppClean) {
        return AutoTabsScaffold(
          // объявление всех окон приложения
          routes: const [
            ScheduleRoute(),
            CallRoute(),
            MoreRouter(),
          ],
          animationDuration: const Duration(milliseconds: 400),
          animationCurve: Curves.easeInOutCubic,
          navigatorObservers: () => [HeroController()],
          // отрисовка нижнего меню навигации
          bottomNavigationBuilder: (_, tabsRouter) {
            return SafeArea(
              left: false,
              top: false,
              right: false,
              bottom: true,
              child: SalomonBottomBar(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: [
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.calendar_today_rounded),
                    title: const Text('Расписание'),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.schedule),
                    title: const Text('Звонки'),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.more_horiz),
                    title: const Text('Ещё'),
                  ),
                ],
              ),
            );
          },
        );
      }
      return Container();
    }, listener: (context, state) {
      if (state is AppOnboarding) {
        context.router.replace(const OnBoardingRoute());
      }
    });
  }
}
