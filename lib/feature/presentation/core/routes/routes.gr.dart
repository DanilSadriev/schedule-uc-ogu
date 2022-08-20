// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i12;
import 'package:raspisanie/feature/presentation/pages/call_schedule/call_schedule.dart'
    as _i4;
import 'package:raspisanie/feature/presentation/pages/home_page.dart' as _i1;
import 'package:raspisanie/feature/presentation/pages/more/about.dart' as _i7;
import 'package:raspisanie/feature/presentation/pages/more/app_settings/app_settings.dart'
    as _i9;
import 'package:raspisanie/feature/presentation/pages/more/app_settings/widgets/lesson_card_settings.dart'
    as _i10;
import 'package:raspisanie/feature/presentation/pages/more/app_settings/widgets/select_format_calendar_page.dart'
    as _i11;
import 'package:raspisanie/feature/presentation/pages/more/more_page.dart'
    as _i6;
import 'package:raspisanie/feature/presentation/pages/more/support_page.dart'
    as _i8;
import 'package:raspisanie/feature/presentation/pages/onboarding/onboarding_page.dart'
    as _i2;
import 'package:raspisanie/feature/presentation/pages/schedule/schedule_page.dart'
    as _i3;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    OnBoardingRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.OnBoardingPage());
    },
    ScheduleRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.SchedulePage());
    },
    CallRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.CallPage());
    },
    MoreRouter.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    MoreRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i6.MorePage());
    },
    AboutRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i7.AboutPage());
    },
    SupportRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: _i8.SupportPage());
    },
    AppSettingsRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i9.AppSettingsPage());
    },
    LessonCardSettings.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i10.LessonCardSettings());
    },
    SelectFormatCalendarRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i11.SelectFormatCalendarPage());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(HomeRoute.name, path: '/', children: [
          _i5.RouteConfig(ScheduleRoute.name,
              path: 'schedule', parent: HomeRoute.name),
          _i5.RouteConfig(CallRoute.name, path: 'call', parent: HomeRoute.name),
          _i5.RouteConfig(MoreRouter.name,
              path: 'more',
              parent: HomeRoute.name,
              children: [
                _i5.RouteConfig(MoreRoute.name,
                    path: '', parent: MoreRouter.name),
                _i5.RouteConfig(AboutRoute.name,
                    path: 'about', parent: MoreRouter.name),
                _i5.RouteConfig(SupportRoute.name,
                    path: 'support', parent: MoreRouter.name),
                _i5.RouteConfig(AppSettingsRoute.name,
                    path: 'appSettings', parent: MoreRouter.name),
                _i5.RouteConfig(LessonCardSettings.name,
                    path: 'lessonCardSetting', parent: MoreRouter.name),
                _i5.RouteConfig(SelectFormatCalendarRoute.name,
                    path: 'selectCalendarFormat', parent: MoreRouter.name)
              ])
        ]),
        _i5.RouteConfig(OnBoardingRoute.name, path: '/onboarding'),
        _i5.RouteConfig('*#redirect',
            path: '*', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.OnBoardingPage]
class OnBoardingRoute extends _i5.PageRouteInfo<void> {
  const OnBoardingRoute() : super(OnBoardingRoute.name, path: '/onboarding');

  static const String name = 'OnBoardingRoute';
}

/// generated route for
/// [_i3.SchedulePage]
class ScheduleRoute extends _i5.PageRouteInfo<void> {
  const ScheduleRoute() : super(ScheduleRoute.name, path: 'schedule');

  static const String name = 'ScheduleRoute';
}

/// generated route for
/// [_i4.CallPage]
class CallRoute extends _i5.PageRouteInfo<void> {
  const CallRoute() : super(CallRoute.name, path: 'call');

  static const String name = 'CallRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class MoreRouter extends _i5.PageRouteInfo<void> {
  const MoreRouter({List<_i5.PageRouteInfo>? children})
      : super(MoreRouter.name, path: 'more', initialChildren: children);

  static const String name = 'MoreRouter';
}

/// generated route for
/// [_i6.MorePage]
class MoreRoute extends _i5.PageRouteInfo<void> {
  const MoreRoute() : super(MoreRoute.name, path: '');

  static const String name = 'MoreRoute';
}

/// generated route for
/// [_i7.AboutPage]
class AboutRoute extends _i5.PageRouteInfo<void> {
  const AboutRoute() : super(AboutRoute.name, path: 'about');

  static const String name = 'AboutRoute';
}

/// generated route for
/// [_i8.SupportPage]
class SupportRoute extends _i5.PageRouteInfo<void> {
  const SupportRoute() : super(SupportRoute.name, path: 'support');

  static const String name = 'SupportRoute';
}

/// generated route for
/// [_i9.AppSettingsPage]
class AppSettingsRoute extends _i5.PageRouteInfo<void> {
  const AppSettingsRoute() : super(AppSettingsRoute.name, path: 'appSettings');

  static const String name = 'AppSettingsRoute';
}

/// generated route for
/// [_i10.LessonCardSettings]
class LessonCardSettings extends _i5.PageRouteInfo<void> {
  const LessonCardSettings()
      : super(LessonCardSettings.name, path: 'lessonCardSetting');

  static const String name = 'LessonCardSettings';
}

/// generated route for
/// [_i11.SelectFormatCalendarPage]
class SelectFormatCalendarRoute extends _i5.PageRouteInfo<void> {
  const SelectFormatCalendarRoute()
      : super(SelectFormatCalendarRoute.name, path: 'selectCalendarFormat');

  static const String name = 'SelectFormatCalendarRoute';
}
