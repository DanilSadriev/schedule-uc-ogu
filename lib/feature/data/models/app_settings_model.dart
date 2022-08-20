import 'dart:convert';

import 'package:raspisanie/feature/domain/entities/app_settings.dart';

// модель настроек приложения
class AppSettingsModel extends AppSettings {
  const AppSettingsModel({
    required bool onboardingShown,
  }) : super(
          onboardingShown: onboardingShown,
        );

  factory AppSettingsModel.fromRawJson(String str) =>
      AppSettingsModel.fromJson(json.decode(str));

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      onboardingShown: json['onboarding_shown'],
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'onboarding_shown': onboardingShown,
      };
}
