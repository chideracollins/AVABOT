import "package:flutter/material.dart";

import "../constants/colors.dart";
import "custom_themes/text_themes.dart";

class Themes {
  Themes._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    disabledColor: AppColors.hintAndDisabledColor,
    hintColor: AppColors.hintAndDisabledColor,
    textTheme: TextThemes.lightTextTheme,
    colorScheme: ColorScheme.light(
      surface: Colors.white,
      primary: Colors.red.shade200,
      secondary: const Color.fromARGB(255, 26, 58, 86),
      tertiary: const Color.fromARGB(255, 64, 160, 69),
      onPrimary: Colors.red,
      onSecondary: Colors.red,
      onSurface: Colors.red,
      outline: Colors.red,
      error: Colors.red,
    ),
  );

  static ThemeData darkTheme = ThemeData();
}
