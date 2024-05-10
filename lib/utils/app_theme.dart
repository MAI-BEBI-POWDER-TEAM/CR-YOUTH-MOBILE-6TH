import 'package:flutter/material.dart';
import 'package:notez/utils/extension/app_theme_ext.dart';

class AppThemeUtils {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: kPrimaryWhite,
    primaryColor: kPrimaryWhite,
    cardColor: kSecondaryWhite,
    useMaterial3: true,
    fontFamily: 'Poppins',
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kPrimaryBlack,
    primaryColor: kPrimaryBlack,
    cardColor: kSecondaryBlack,
    useMaterial3: true,
    fontFamily: 'Poppins',
  );
}
