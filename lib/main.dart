// ignore_for_file: depend_on_referenced_packages
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raspisanie/app_observer.dart';
import 'package:raspisanie/common/theme/theme.dart';
import 'package:raspisanie/feature/presentation/bloc/added_groups_bloc/added_groups_bloc.dart';
import 'package:raspisanie/feature/presentation/bloc/app_cubit/app_cubit.dart';
import 'package:raspisanie/feature/presentation/bloc/call_schedule/call_event.dart';
import 'package:raspisanie/feature/presentation/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:raspisanie/feature/presentation/bloc/schedule_bloc/schedule_event.dart';
import 'package:raspisanie/feature/presentation/core/routes/routes.gr.dart';

import 'package:raspisanie/locator_service.dart' as di;
import 'feature/presentation/bloc/call_schedule/call_bloc.dart';
import 'feature/presentation/bloc/name_groups_bloc/name_groups_bloc.dart';
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init(); //инициализация зависимостей

  await Firebase.initializeApp();

  await FirebaseAnalytics.instance.logAppOpen();

  // Initialize Crash report
  const bool enableCrashlytics = !kDebugMode;
  await FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(enableCrashlytics);

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  //отрисовка интерфейса
  Bloc.observer = AppObserver();
  runApp(MyApp());
}

//класс приложения
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  //объявление переменной роутера навигации
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    //фиксация ориентации экрана
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    // удаление цвета строки состояния системы
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) => sl<AppCubit>(),
          lazy: false,
        ),
        BlocProvider<AddedGroupsBloc>(
            create: (context) => sl<AddedGroupsBloc>()),
        BlocProvider<CallBloc>(
          create: (context) => sl<CallBloc>()..add(const CallView(true)),
          lazy: false,
        ),
        BlocProvider<ScheduleBloc>(
          create: (context) => sl<ScheduleBloc>(),
          lazy: false,
        ),
        BlocProvider<NameGroupsBloc>(
          create: (context) => sl<NameGroupsBloc>(),
        )
      ],
      child: AdaptiveTheme(
        light: lightTheme,
        dark: darkTheme,
        initial: AdaptiveThemeMode.system, //установка темы приложения
        builder: (theme, darkTheme) => MaterialApp.router(
          // добавление локализации для приложения
          // ignore: prefer_const_literals_to_create_immutables
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ru'),
          ],
          // установка языка приложения
          locale: const Locale('ru'),
          debugShowCheckedModeBanner: false,
          title: 'Расписание УК ОГУ',
          theme: theme,
          routerDelegate: _appRouter.delegate(
            navigatorObservers: () => [
              FirebaseAnalyticsObserver(
                analytics: FirebaseAnalytics.instance,
              ),
            ],
          ),
          routeInformationParser: _appRouter.defaultRouteParser(),
        ),
      ),
    );
  }
}
