// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:raspisanie/locator_service.dart';

import '../../../../../common/theme/colors.dart';
// import 'package:url_launcher/url_launcher.dart';

// окно О приложении
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('О приложении'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            _appInfo(context),
            const SizedBox(
              height: 16.0,
            ),
            _textAbout(context),
            const SizedBox(
              height: 16.0,
            ),
            _cautionText(context),
            const SizedBox(
              height: 16.0,
            ),
            _copyrightText(context),
          ],
        ),
      ),
    );
  }

  Widget _textAbout(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text:
                'Расписание берется с оффициального сайта Университетского колледжа ОГУ ',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          // TextSpan(
          //   text: 'uc.osu.ru',
          //   style: DarkTextTheme.bodyRegular
          //       .copyWith(color: DarkThemeColors.primary),
          //   recognizer: TapGestureRecognizer()
          //     ..onTap = () {
          //       launch('https://www.uc.osu.ru/');
          //     },
          // ),
        ],
      ),
    );
  }

  Widget _copyrightText(BuildContext context) {
    return Text(
      '© 2022 Садриев Даниль Рифатович',
      style: Theme.of(context)
          .textTheme
          .caption
          ?.copyWith(color: DarkThemeColors.gray),
    );
  }

  Widget _cautionText(BuildContext context) {
    return Text(
      'Сервис ${sl<PackageInfo>().appName} не содержит информацию, не предназначенную для несовершеннолетних.',
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: DarkThemeColors.gray),
      textAlign: TextAlign.center,
    );
  }

  Widget _appInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          child: Theme.of(context).brightness == Brightness.dark
              ? Image.asset(
                  'assets/icons/ic_launcher_foreground_dark.png',
                  height: 104.0,
                  width: 104.0,
                )
              : Image.asset(
                  'assets/icons/ic_launcher_foreground_light.png',
                  height: 104.0,
                  width: 104.0,
                ),
        ),
        Text(
          sl<PackageInfo>().appName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          'Версия ${sl<PackageInfo>().version}, сборка ${sl<PackageInfo>().buildNumber}',
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: DarkThemeColors.gray),
        ),
      ],
    );
  }
}
