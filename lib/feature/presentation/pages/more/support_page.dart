import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/theme/colors.dart';

class SupportPage extends StatelessWidget {
  SupportPage({Key? key}) : super(key: key);

  final Uri developerUri = Uri.parse('https://t.me/sadrievdan');
  final Uri chanelUri = Uri.parse('https://t.me/raspUkOgu');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поддержка'),
      ),
      body: SettingsList(
        platform: DevicePlatform.iOS,
        darkTheme: const SettingsThemeData(
          settingsListBackground: DarkThemeColors.background,
          settingsSectionBackground: DarkThemeColors.lightGray,
        ),
        lightTheme: const SettingsThemeData(
          settingsListBackground: LightThemeColors.background,
          settingsSectionBackground: LightThemeColors.lightGray,
        ),
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile.navigation(
                title: Text(
                  'Телеграмм разработчика',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                description: Text(
                  'Вы будете перенаправлены в чат с разработчиком в телеграмм.',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Theme.of(context).disabledColor),
                ),
                onPressed: ((context) {
                  openUrl(developerUri);
                }),
              ),
              SettingsTile.navigation(
                title: Text(
                  'Канал приложения',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                description: Text(
                  'Вы будете перенаправлены в оффициальный канал приложения в телеграмм.',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Theme.of(context).disabledColor),
                ),
                onPressed: ((context) {
                  openUrl(chanelUri);
                }),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> openUrl(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
