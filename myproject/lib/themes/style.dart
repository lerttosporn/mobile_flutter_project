import 'package:flutter/material.dart';
import 'package:myproject/themes/colors.dart';

class AppTheme {
  //Light theme

  // Custom text theme
  static final customTextTheme = TextTheme(
    bodyMedium: TextStyle(fontSize: 16),
    bodyLarge: TextStyle(fontSize: 24),
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    fontFamily: "NotoSansThai",
    primaryColor: primary,
    primaryColorDark: primaryDark,
    primaryColorLight: primaryLight,
    hoverColor: divider,
    hintColor: accent,
    colorScheme: const ColorScheme.light(primary: primary),
    iconTheme: const IconThemeData(color: primaryText),
    scaffoldBackgroundColor: Colors.blueGrey[100],
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'NotoSansThai',
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: icons,
      ),
      backgroundColor: primary,
      foregroundColor: icons,
      iconTheme: IconThemeData(color: icons),
    ),
  );

  //Darktheme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    fontFamily: "NotoSansThai",
    primaryColor: primary,
    primaryColorDark: primaryDark,
    primaryColorLight: primaryLight,
    hoverColor: divider,
    hintColor: accent,
    colorScheme: const ColorScheme.dark(primary: icons),
    iconTheme: const IconThemeData(color: icons),
    scaffoldBackgroundColor: primaryText,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'NotoSansThai',
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: icons,
      ),
      backgroundColor: primaryText,
      foregroundColor: icons,
      iconTheme: IconThemeData(color: icons),
    ),
  );
}
