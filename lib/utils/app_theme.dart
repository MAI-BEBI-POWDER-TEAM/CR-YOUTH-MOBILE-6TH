import 'package:flutter/material.dart';

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

// DARK THEME COLORS
const kPrimaryBlack = Color.fromRGBO(27, 27, 27, 1);
const kSecondaryBlack = Color.fromRGBO(39, 39, 39, 1);

// LIGHT THEME COLORS
const kPrimaryWhite = Color.fromRGBO(245, 245, 245, 1);
const kSecondaryWhite = Color.fromRGBO(226, 226, 226, 1);

// OTHER COLORS
const kWhite = Color.fromRGBO(255, 255, 255, 1);
const kGrey = Color.fromRGBO(127, 127, 127, 1);
const kBlue = Color.fromRGBO(52, 113, 255, 1);
