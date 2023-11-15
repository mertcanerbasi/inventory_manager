import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../utils/constants/padding_constants.dart';

abstract class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.white,
      centerTitle: true,
    ),
    scaffoldBackgroundColor: Colors.white,

    /// TODO - Fix this
    // pageTransitionsTheme: const PageTransitionsTheme(
    //   builders: {
    //     TargetPlatform.android: const ZoomPageTransitionsBuilder(),
    //     TargetPlatform.iOS: const ZoomPageTransitionsBuilder(),
    //   },
    // ),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) => const Icon(
        Icons.arrow_back_ios,
        color: Colors.red,
      ),
      closeButtonIconBuilder: (context) => const Icon(
        Icons.close,
        color: Colors.red,
      ),
    ),
    splashColor: Colors.transparent,
    brightness: Brightness.light,
    primaryColor: Colors.black,
    fontFamily: 'IBM',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding: PaddingConstants.symmetic5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.red,
      secondary: Colors.black,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.black,
      centerTitle: true,
    ),
    scaffoldBackgroundColor: Colors.black,
    splashColor: Colors.transparent,
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    fontFamily: 'IBM',
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.red,
        secondary: Colors.white,
        brightness: Brightness.dark),
  );
}
