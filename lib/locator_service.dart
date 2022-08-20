import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:raspisanie/feature/data/datasources/app_settings_local.dart';
import 'package:raspisanie/feature/data/datasources/call_schedule_local_data_source.dart';
import 'package:raspisanie/feature/data/datasources/call_schedule_remote_data_source.dart';
import 'package:raspisanie/feature/data/datasources/added_groups.local.dart';
import 'package:raspisanie/feature/data/datasources/name_groups_remote.dart';
import 'package:raspisanie/feature/data/datasources/schedule_remote_data_source.dart';
import 'package:raspisanie/feature/data/repository/app_settings_repository_impl.dart';
import 'package:raspisanie/feature/data/repository/call_schedule_repository_impl.dart';
import 'package:raspisanie/feature/data/repository/added_groups_repository_impl.dart';
import 'package:raspisanie/feature/data/repository/name_groups_repository_impl.dart';
import 'package:raspisanie/feature/data/repository/schedule_repository_impl.dart';
import 'package:raspisanie/feature/domain/repository/added_groups_repository.dart';
import 'package:raspisanie/feature/domain/repository/app_settings_repository.dart';
import 'package:raspisanie/feature/domain/repository/call_schedule_repository.dart';
import 'package:raspisanie/feature/domain/repository/name_groups_repository.dart';
import 'package:raspisanie/feature/domain/repository/schedule_repository.dart';
import 'package:raspisanie/feature/domain/usecases/added_groups/add_group.dart';
import 'package:raspisanie/feature/domain/usecases/added_groups/delete_group.dart';
import 'package:raspisanie/feature/domain/usecases/added_groups/get_active_group.dart';
import 'package:raspisanie/feature/domain/usecases/added_groups/get_all_groups.dart';
import 'package:raspisanie/feature/domain/usecases/added_groups/update_active_group.dart';
import 'package:raspisanie/feature/domain/usecases/added_groups/update_group_name.dart';
import 'package:raspisanie/feature/domain/usecases/app_settings/get_app_settings.dart';
import 'package:raspisanie/feature/domain/usecases/app_settings/set_app_settings.dart';
import 'package:raspisanie/feature/domain/usecases/call_schedule/get_call_schedule.dart';
import 'package:raspisanie/feature/domain/usecases/name_groups/get_groups.dart';
import 'package:raspisanie/feature/domain/usecases/schedule/get_all_schedule.dart';
import 'package:raspisanie/feature/presentation/bloc/added_groups_bloc/added_groups_bloc.dart';
import 'package:raspisanie/feature/presentation/bloc/app_cubit/app_cubit.dart';
import 'package:raspisanie/feature/presentation/bloc/name_groups_bloc/name_groups_bloc.dart';
import 'package:raspisanie/feature/presentation/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:raspisanie/utils/application_management.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/data/datasources/schedule_local.dart';
import 'feature/domain/usecases/schedule/get_schedule_settings.dart';
import 'feature/domain/usecases/schedule/set_schedule_settings.dart';
import 'feature/presentation/bloc/call_schedule/call_bloc.dart';

final sl = GetIt.instance;

// инициализация объектов приложения
Future<void> init() async {
  // Bloc / Cubit
  sl.registerFactory(
    () => ScheduleBloc(
      getAllSchedule: sl(),
      getScheduleSettings: sl(),
      setScheduleSettings: sl(),
    ),
  );
  sl.registerFactory(
    () => AddedGroupsBloc(
      updateActiveGroup: sl(),
      addGroup: sl(),
      getAllGroups: sl(),
      deleteGroup: sl(),
      updateGroupName: sl(),
    ),
  );
  sl.registerFactory(
    () => AppCubit(
      getAppSettings: sl(),
      setAppSettings: sl(),
    ),
  );
  sl.registerFactory(
    () => CallBloc(
      getCallSchedule: sl(),
    ),
  );
  sl.registerFactory(
    () => NameGroupsBloc(
      getGroups: sl(),
    ),
  );

  //UseCases
  sl.registerLazySingleton(() => GetAllSchedule(sl()));
  sl.registerLazySingleton(() => GetAllGroups(sl()));
  sl.registerLazySingleton(() => AddGroup(sl()));
  sl.registerLazySingleton(() => DeleteGroup(sl()));
  sl.registerLazySingleton(() => GetActiveGroup(sl()));
  sl.registerLazySingleton(() => UpdateActiveGroup(sl()));
  sl.registerLazySingleton(() => UpdateGroupName(sl()));
  sl.registerLazySingleton(() => SetAppSettings(sl()));
  sl.registerLazySingleton(() => GetAppSettings(sl()));
  sl.registerLazySingleton((() => GetCallSchedule(sl())));
  sl.registerLazySingleton(() => GetScheduleSettings(sl()));
  sl.registerLazySingleton(() => SetScheduleSettings(sl()));
  sl.registerLazySingleton(() => GetGroups(sl()));

  //Repository
  sl.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<AddedGroupsRepository>(
    () => AddedGroupsRepositoryImpl(
      addedGroupsLocal: sl(),
    ),
  );
  sl.registerLazySingleton<CallScheduleRepository>(
    () => CallScheduleRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<AppSettingsRepository>(
    () => AppSettingsRepositoryImpl(
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<NameGroupsRepository>(
    () => NameGroupsRepositoryImpl(
      nameGroupsRemote: sl(),
    ),
  );

  sl.registerLazySingleton<CallScheduleRemoteDataSource>(
    () => CallScheduleRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<CallScheduleLocalDataSource>(
    () => CallScheduleLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<ScheduleRemoteDataSource>(
    () => ScheduleRemoteDataSourceImpl(
      client: http.Client(),
    ),
  );
  sl.registerLazySingleton<ScheduleLocalData>(
      () => ScheduleLocalDataImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<AddedGroupsLocal>(
    () => AddedGroupsLocalImpl(
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<AppSettingsLocal>(
    () => AppSettingsLocalImpl(
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<NameGroupsRemote>(
    () => NameGroupsRemoteImpl(),
  );

  sl.registerLazySingleton<ApplicationManagement>(
    () => ApplicationManagement(
      sharedPreferences: sl(),
    ),
  );

  //Core
  //здесь должна быть функция проверки интернета

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  sl.registerLazySingleton(() => packageInfo);
  sl.registerLazySingleton(() => Restart.restartApp());

  //Firebase
  // sl.registerLazySingleton(() => AnalyticsService());
}
