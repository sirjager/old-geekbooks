import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  AppTheme._();

  //**********************For Light Themes***************************
  static const Color themeColorLight = Colors.green;

  static const Color backgroundColorLight = Colors.white;
  static const Color accentColorLight = Color(0xffA239EA);
  static const Color buttonColorLight = Color(0xFFCCD0F6);
  static const Color headlineColorLight = Colors.black;
  static const Color subtitleColorLight = Color(0xFF222831);

  //==========================For Dark Themes=======================*
  static const Color themeColorDark = Colors.red;

  static const Color backgroundColorDark = Color(0xff202021);
  static const Color accentColorDark = Color(0xff2E2E2E);
  static const Color buttonColorDark = Color(0xff2E2E2E);
  static const Color headlineColorDark = Color(0xffF0F1F1);
  static const Color subtitleColorDark = Color(0xffA0A1A1);

  //
  //!           LIGHT TEXT SYLE
  //
  static final TextStyle buttonLight = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w800,
    color: headlineColorLight,
  );

  static final TextStyle captionLight = TextStyle(
    fontWeight: FontWeight.w800,
    color: AppTheme.headlineColorLight,
  );

  static final TextStyle tsHeadline1 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w900,
    color: AppTheme.headlineColorLight,
  );
  static final TextStyle tsHeadline2 = tsHeadline1.copyWith(
    fontSize: 27,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle tsHeadline3 = tsHeadline1.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle tsHeadline4 = tsHeadline1.copyWith(
    fontSize: 21,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle tsHeadline5 = tsHeadline1.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle tsHeadline6 = tsHeadline1.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w300,
  );

  static final TextStyle tsSubtitle1 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppTheme.subtitleColorLight,
  );

  static final TextStyle tsSubtitle2 = tsSubtitle1.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle tsBodyText1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: subtitleColorLight,
  );

  static final TextStyle tsBodyText2 = tsBodyText1.copyWith(fontSize: 12);

  //
  //
  //!             DARK TEXT STYLE
  //
  //
  //
  static final TextStyle buttonDark =
      buttonLight.copyWith(color: AppTheme.headlineColorDark);

  static final TextStyle captionDark =
      captionLight.copyWith(color: AppTheme.headlineColorDark);

  static final TextStyle tsHeadline1Dark =
      tsHeadline1.copyWith(color: AppTheme.headlineColorDark);

  static final TextStyle tsHeadline2Dark =
      tsHeadline2.copyWith(color: AppTheme.headlineColorDark);

  static final TextStyle tsHeadline3Dark =
      tsHeadline3.copyWith(color: AppTheme.headlineColorDark);

  static final TextStyle tsHeadline4Dark =
      tsHeadline4.copyWith(color: AppTheme.headlineColorDark);

  static final TextStyle tsHeadline5Dark =
      tsHeadline5.copyWith(color: AppTheme.headlineColorDark);

  static final TextStyle tsHeadline6Dark =
      tsHeadline6.copyWith(color: AppTheme.headlineColorDark);

  static final TextStyle tsSubtitle1Dark =
      tsSubtitle1.copyWith(color: AppTheme.subtitleColorDark);

  static final TextStyle tsSubtitle2Dark =
      tsSubtitle2.copyWith(color: AppTheme.subtitleColorDark);

  static final TextStyle tsBodyText1Dark =
      tsBodyText1.copyWith(color: AppTheme.subtitleColorDark);

  static final TextStyle tsBodyText2Dark =
      tsBodyText2.copyWith(color: AppTheme.subtitleColorDark);
  //
  //
  //!           LIGHT THEME PROPERTIES

  static final TextTheme lightTextTheme = TextTheme(
    button: buttonLight,
    caption: captionLight,
    headline1: tsHeadline1,
    headline2: tsHeadline2,
    headline3: tsHeadline3,
    headline4: tsHeadline4,
    headline5: tsHeadline5,
    headline6: tsHeadline6,
    subtitle1: tsSubtitle1,
    subtitle2: tsSubtitle2,
    bodyText1: tsBodyText1,
    bodyText2: tsBodyText2,
  );
  //
  //
  //!            DARK THEME PROPERTIES

  static final TextTheme darkTextTheme = TextTheme(
    button: buttonDark,
    caption: captionDark,
    headline1: tsHeadline1Dark,
    headline2: tsHeadline2Dark,
    headline3: tsHeadline3Dark,
    headline4: tsHeadline4Dark,
    headline5: tsHeadline5Dark,
    headline6: tsHeadline6Dark,
    subtitle1: tsSubtitle1Dark,
    subtitle2: tsSubtitle2Dark,
    bodyText1: tsBodyText1Dark,
    bodyText2: tsBodyText2Dark,
  );

  static final SystemUiOverlayStyle systemUiLight = SystemUiOverlayStyle(
    // Statusbar
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    // Navigationbar
    systemNavigationBarColor: backgroundColorLight,
    systemNavigationBarDividerColor: backgroundColorLight,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  static final SystemUiOverlayStyle systemUiDark = SystemUiOverlayStyle(
    // Statusbar
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    // Navigationbar
    systemNavigationBarColor: backgroundColorDark,
    systemNavigationBarDividerColor: backgroundColorDark,
    systemNavigationBarIconBrightness: Brightness.light,
    //
  );
  //

  //
  // ?        Light Theme
  //

  //
  //
  static final ThemeData themeLight = ThemeData(
    textTheme: lightTextTheme,
    brightness: Brightness.light,
    primarySwatch: themeColorLight as MaterialColor,
    primaryColor: themeColorLight,
    colorScheme: ColorScheme.light(),
    buttonColor: AppTheme.buttonColorLight,
    dividerColor: Colors.transparent,
    scaffoldBackgroundColor: AppTheme.backgroundColorLight,
    accentColor: accentColorLight,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  //
  //?           Dark Theme
  //
  //
  static final ThemeData themeDark = ThemeData(
    textTheme: darkTextTheme,
    brightness: Brightness.dark,
    primaryColor: themeColorDark,
    primarySwatch: themeColorDark as MaterialColor,
    colorScheme: ColorScheme.dark(),
    buttonColor: AppTheme.buttonColorDark,
    dividerColor: Colors.transparent,
    scaffoldBackgroundColor: AppTheme.backgroundColorDark,
    accentColor: accentColorDark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
