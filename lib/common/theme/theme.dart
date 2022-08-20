import 'package:flutter/material.dart';
import 'package:raspisanie/common/theme/colors.dart';

// темы
abstract class DarkTextTheme {
  static const headline = TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  static const inter = TextStyle(
    color: DarkThemeColors.text,
    fontFamily: 'Rubik',
    letterSpacing: 0,
  );

  static final h0 = headline.copyWith(fontSize: 60);
  static final h1 = headline.copyWith(fontSize: 48);
  static final h2 = headline.copyWith(fontSize: 40);
  static final h3 = headline.copyWith(fontSize: 36);
  static final h4 = headline.copyWith(fontSize: 32);
  static final h5 = headline.copyWith(fontSize: 24);
  static final h6 = headline.copyWith(fontSize: 20);
  static final title = headline.copyWith(fontSize: 18);

  static final titleM = inter.copyWith(
      fontSize: 16, fontWeight: FontWeight.w600, color: DarkThemeColors.white);
  static final titleS = inter.copyWith(
      fontSize: 14, fontWeight: FontWeight.w600, color: DarkThemeColors.white);
  static final buttonL = inter.copyWith(
      fontSize: 16, fontWeight: FontWeight.w700, color: DarkThemeColors.white);
  static final buttonS =
      inter.copyWith(fontSize: 14, fontWeight: FontWeight.w700);
  static final tab = inter.copyWith(fontSize: 14, fontWeight: FontWeight.w600);
  static final bodyL =
      inter.copyWith(fontSize: 14, fontWeight: FontWeight.w500);
  static final body = inter.copyWith(fontSize: 13, fontWeight: FontWeight.w500);
  static final bodyBold =
      inter.copyWith(fontSize: 14, fontWeight: FontWeight.w700);
  static final bodyRegular = inter.copyWith(fontSize: 13);
  static final captionL =
      inter.copyWith(fontSize: 12, fontWeight: FontWeight.w500);
  static final captionS =
      inter.copyWith(fontSize: 11, fontWeight: FontWeight.w500);
  static final chip = inter.copyWith(
      fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.50);
}

abstract class LightTextTheme {
  static const headline = TextStyle(
    color: Colors.black,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  static const inter = TextStyle(
    color: LightThemeColors.text,
    fontFamily: 'Rubik',
    letterSpacing: 0,
  );

  // static final h1 = headline.copyWith(fontSize: 48);
  // static final h2 = headline.copyWith(fontSize: 40);
  // static final h3 = headline.copyWith(fontSize: 36);
  static final h4 = headline.copyWith(fontSize: 32);
  static final h5 = headline.copyWith(fontSize: 24);
  // static final h6 = headline.copyWith(fontSize: 20);
  static final title = headline.copyWith(fontSize: 18);

  static final titleM =
      inter.copyWith(fontSize: 16, fontWeight: FontWeight.w600);
  static final titleS =
      inter.copyWith(fontSize: 14, fontWeight: FontWeight.w600);
  static final buttonL = inter.copyWith(
      fontSize: 16, fontWeight: FontWeight.w700, color: LightThemeColors.white);
  static final buttonS = inter.copyWith(
      fontSize: 14, fontWeight: FontWeight.w700, color: LightThemeColors.white);
  // static final tab = inter.copyWith(fontSize: 14, fontWeight: FontWeight.w600);
  static final bodyL =
      inter.copyWith(fontSize: 14, fontWeight: FontWeight.w500);
  static final body = inter.copyWith(fontSize: 13, fontWeight: FontWeight.w500);
  // static final bodyBold =
  //     inter.copyWith(fontSize: 14, fontWeight: FontWeight.w700);
  static final bodyRegular = inter.copyWith(fontSize: 13);
  static final captionL =
      inter.copyWith(fontSize: 12, fontWeight: FontWeight.w500);
  static final captionS =
      inter.copyWith(fontSize: 11, fontWeight: FontWeight.w500);
  static final chip = inter.copyWith(
      fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.50);
}

final darkTheme = ThemeData.dark().copyWith(
  useMaterial3: true,
  primaryColor: DarkThemeColors.blue,
  primaryColorLight: DarkThemeColors.white,
  scaffoldBackgroundColor: DarkThemeColors.background,
  backgroundColor: DarkThemeColors.background,
  cardColor: DarkThemeColors.lightGray,
  disabledColor: DarkThemeColors.gray,
  hoverColor: DarkThemeColors.text,
  selectedRowColor: DarkThemeColors.green,
  iconTheme: const IconThemeData(color: DarkThemeColors.text),
  dialogTheme: DialogTheme(
      backgroundColor: DarkThemeColors.lightGray,
      titleTextStyle: DarkTextTheme.title,
      contentTextStyle: DarkTextTheme.body),
  textTheme: TextTheme(
    headlineMedium: DarkTextTheme.h4,
    headlineSmall: DarkTextTheme.h5,
    titleLarge: DarkTextTheme.title,
    titleMedium: DarkTextTheme.titleM,
    titleSmall: DarkTextTheme.titleS,
    displaySmall: DarkTextTheme.buttonS,
    bodyLarge: DarkTextTheme.bodyL,
    bodyMedium: DarkTextTheme.body,
    bodySmall: DarkTextTheme.bodyRegular,
    labelLarge: DarkTextTheme.captionL,
    labelSmall: DarkTextTheme.chip,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: DarkTextTheme.titleM.copyWith(
      color: DarkThemeColors.gray,
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: DarkThemeColors.blue),
    ),
  ),
  listTileTheme: ListTileThemeData(
    textColor: DarkThemeColors.text,
    tileColor: DarkThemeColors.lightGray,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelStyle: DarkTextTheme.titleS,
    labelStyle: DarkTextTheme.titleS,
    labelColor: DarkThemeColors.white,
    unselectedLabelColor: DarkThemeColors.text,
    overlayColor: MaterialStateProperty.all(Colors.transparent),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(DarkThemeColors.white),
      textStyle: MaterialStateProperty.all(DarkTextTheme.buttonL),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      textStyle: MaterialStateProperty.all(
          LightTextTheme.buttonL.copyWith(color: Colors.white)),
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.all(DarkThemeColors.blue),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  ),
  cardTheme: CardTheme(
    color: DarkThemeColors.lightGray,
    elevation: 0.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),
  appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: DarkThemeColors.text),
      titleSpacing: 24,
      backgroundColor: DarkThemeColors.background,
      shadowColor: Colors.transparent,
      surfaceTintColor: DarkThemeColors.background,
      titleTextStyle: DarkTextTheme.title,
      centerTitle: false),
  bottomNavigationBarTheme: ThemeData.dark().bottomNavigationBarTheme.copyWith(
        type: BottomNavigationBarType.shifting,
        backgroundColor: DarkThemeColors.background,
        unselectedItemColor: DarkThemeColors.gray,
        selectedLabelStyle: DarkTextTheme.captionL,
        unselectedLabelStyle: DarkTextTheme.captionS,
      ),
);

final lightTheme = ThemeData.light().copyWith(
  useMaterial3: true,
  primaryColor: LightThemeColors.blue,
  primaryColorLight: LightThemeColors.white,
  scaffoldBackgroundColor: LightThemeColors.background,
  backgroundColor: LightThemeColors.background,
  cardColor: LightThemeColors.lightGray,
  disabledColor: LightThemeColors.gray,
  selectedRowColor: LightThemeColors.green,
  iconTheme: const IconThemeData(color: LightThemeColors.text),
  dialogTheme: DialogTheme(
      backgroundColor: LightThemeColors.background,
      titleTextStyle: LightTextTheme.title,
      contentTextStyle: LightTextTheme.body),
  textTheme: TextTheme(
    headlineMedium: LightTextTheme.h4,
    headlineSmall: LightTextTheme.h5,
    titleLarge: LightTextTheme.title,
    titleMedium: LightTextTheme.titleM,
    titleSmall: LightTextTheme.titleS,
    displaySmall: LightTextTheme.buttonS,
    bodyLarge: LightTextTheme.bodyL,
    bodyMedium: LightTextTheme.body,
    bodySmall: LightTextTheme.bodyRegular,
    labelLarge: LightTextTheme.captionL,
    labelSmall: LightTextTheme.chip,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: LightTextTheme.titleM.copyWith(
      color: LightThemeColors.gray,
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: LightThemeColors.blue),
    ),
  ),
  listTileTheme: ListTileThemeData(
    textColor: LightThemeColors.text,
    tileColor: LightThemeColors.lightGray,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelStyle: LightTextTheme.titleS,
    labelStyle: LightTextTheme.titleS,
    labelColor: LightThemeColors.text,
    unselectedLabelColor: LightThemeColors.gray,
    overlayColor: MaterialStateProperty.all(Colors.transparent),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(LightThemeColors.blue),
      textStyle: MaterialStateProperty.all(LightTextTheme.buttonL),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      textStyle: MaterialStateProperty.all(
          LightTextTheme.buttonL.copyWith(color: Colors.white)),
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.all(LightThemeColors.blue),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  ),
  cardTheme: CardTheme(
    color: LightThemeColors.lightGray,
    elevation: 0.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),
  appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: LightThemeColors.text),
      titleSpacing: 24,
      backgroundColor: LightThemeColors.background,
      shadowColor: Colors.transparent,
      surfaceTintColor: LightThemeColors.background,
      titleTextStyle: LightTextTheme.title,
      centerTitle: false),
  bottomNavigationBarTheme: ThemeData.dark().bottomNavigationBarTheme.copyWith(
        type: BottomNavigationBarType.shifting,
        backgroundColor: LightThemeColors.background,
        unselectedItemColor: LightThemeColors.gray,
        selectedLabelStyle: LightTextTheme.captionL,
        unselectedLabelStyle: LightTextTheme.captionS,
      ),
);
