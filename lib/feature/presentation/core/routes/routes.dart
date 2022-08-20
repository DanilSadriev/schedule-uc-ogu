import 'package:auto_route/auto_route.dart';
// import 'package:dismissible_page/dismissible_page.dart';
import 'package:raspisanie/feature/presentation/pages/call_schedule/call_schedule.dart';
import 'package:raspisanie/feature/presentation/pages/home_page.dart';
import 'package:raspisanie/feature/presentation/pages/more/support_page.dart';
import 'package:raspisanie/feature/presentation/pages/onboarding/onboarding_page.dart';
import 'package:raspisanie/feature/presentation/pages/schedule/schedule_page.dart';

import '../../pages/more/about.dart';
import '../../pages/more/app_settings/app_settings.dart';
import '../../pages/more/app_settings/widgets/lesson_card_settings.dart';
import '../../pages/more/app_settings/widgets/select_format_calendar_page.dart';
import '../../pages/more/more_page.dart';

// роутер навигации
@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: '/',
      page: HomePage,
      children: [
        AutoRoute(
          path: 'schedule',
          page: SchedulePage,
        ),
        AutoRoute(
          path: 'call',
          page: CallPage,
        ),
        AutoRoute(
          path: 'more',
          name: 'MoreRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: '',
              page: MorePage,
            ),
            AutoRoute(
              path: 'about',
              page: AboutPage,
            ),
            AutoRoute(
              path: 'support',
              page: SupportPage,
            ),
            AutoRoute(
              path: 'appSettings',
              page: AppSettingsPage,
            ),
            AutoRoute(
              path: 'lessonCardSetting',
              page: LessonCardSettings,
            ),
            AutoRoute(
              path: 'selectCalendarFormat',
              page: SelectFormatCalendarPage,
            ),
          ],
        ),
      ],
    ),
    // AutoRoute(
    //   path: 'selection',
    //   name: 'AuthorizationRouter',
    //   page: EmptyRouterPage,
    //   children: [
    //     AutoRoute(
    //       path: '',
    //       page: SelectionPage,
    //     ),
    //     AutoRoute(
    //       path: 'register',
    //       page: RegisterPage,
    //     ),
    //     AutoRoute(
    //       path: 'login',
    //       page: LoginPage,
    //     ),
    //     AutoRoute(
    //       path: 'recovery',
    //       page: PasswordRecoveryPage,
    //     ),
    //   ],
    // ),
    AutoRoute(path: '/onboarding', page: OnBoardingPage),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class $AppRouter {}

// анимация перехода между окнами
// Route<T> transparentRoute<T>(
//     BuildContext context, Widget child, CustomPage<T> page) {
//   return TransparentRoute(
//     settings: page,
//     builder: (context) => child,
//     backgroundColor: Colors.black.withOpacity(0.45),
//     reverseTransitionDuration: const Duration(milliseconds: 350),
//     transitionDuration: const Duration(milliseconds: 350),
//   );
// }
