part of 'app_cubit.dart';

// состояния настроек приложения
abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class AppOnboarding extends AppState {}

class AppUpdatesOnboarding extends AppState {}

class AppClean extends AppState {}
