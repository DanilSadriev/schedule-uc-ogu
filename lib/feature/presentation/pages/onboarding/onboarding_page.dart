import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:raspisanie/common/theme/colors.dart';

import '../../bloc/app_cubit/app_cubit.dart';
import '../../core/routes/routes.gr.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Добро пожаловать!',
              body:
                  'Это приложение было создано для просмотра расписания не только для студентов, но также и для преподователей',
              image: buildImage('assets/images/Saly-16.png'),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(context),
            ),
            PageViewModel(
              title: 'Смотри расписание!',
              body:
                  'Как же легко, оказывается, можно смотреть расписание, а главное – быстро',
              image: buildImage('assets/images/Saly-2.png'),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(context),
            ),
            PageViewModel(
              title: 'Будь в курсе, везде!',
              body:
                  'Иногда так лень заходить на сайт и искать нужную информацию, мы это исправили',
              image: buildImage('assets/images/Saly-11.png'),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(context),
            ),
          ],
          onDone: () {
            context.read<AppCubit>().closeOnboarding();
            context.router.replace(const HomeRoute());
            // context.router.replace(const AuthorizationRouter());
          },
          //ClampingScrollPhysics prevent the scroll offset from exceeding the bounds of the content.
          scrollPhysics: const ClampingScrollPhysics(),
          showDoneButton: true,
          showNextButton: true,
          showSkipButton: true,
          isBottomSafeArea: true,
          baseBtnStyle: Theme.of(context).textButtonTheme.style,
          skip: const Text(
            'Пропуcтить',
          ),
          next:
              const Icon(Icons.arrow_forward_ios, color: DarkThemeColors.white),
          done: const Text(
            'Начать',
          ),
          dotsDecorator: getDotsDecorator(context)),
    );
  }

  //widget to add the image on screen
  Widget buildImage(String imagePath) {
    return Center(
        child: Image.asset(
      imagePath,
      width: 480,
      height: 360,
    ));
  }

  //method to customise the page style
  PageDecoration getPageDecoration(BuildContext context) {
    return PageDecoration(
      titleTextStyle:
          Theme.of(context).textTheme.headlineMedium ?? const TextStyle(),
      imagePadding: const EdgeInsets.only(top: 32),
      pageColor: Theme.of(context).backgroundColor,
      bodyPadding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      titlePadding: const EdgeInsets.only(top: 32),
      bodyTextStyle:
          Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
    );
  }

  //method to customize the dots style
  DotsDecorator getDotsDecorator(BuildContext context) {
    return DotsDecorator(
      spacing: const EdgeInsets.symmetric(horizontal: 2),
      activeColor: Theme.of(context).primaryColor,
      color: Theme.of(context).disabledColor,
      activeSize: const Size(16, 8),
      activeShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }
}
