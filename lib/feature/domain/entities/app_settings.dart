import 'package:equatable/equatable.dart';

// entities настроек приложения
class AppSettings extends Equatable {
  final bool onboardingShown; //показ окна приветсвия

  const AppSettings({
    required this.onboardingShown,
  });

  @override
  List<Object> get props => [
        onboardingShown,
      ];
}
