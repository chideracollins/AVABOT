import "package:flutter/material.dart";

import "../constants/colors.dart";

class Themes {
  Themes._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    disabledColor: AppColors.hintAndDisabledColor,
    hintColor: AppColors.hintAndDisabledColor,
    colorScheme: ColorScheme.light(
      surface: AppColors.bgColor,
      surfaceDim: AppColors.dialogColor,
      onSurfaceVariant: AppColors.drawerTileColor,
      primary: AppColors.primaryColor,
      secondary: AppColors.tertiaryColor,
      tertiary: AppColors.bgAiReply,
      // onSurface: Colors.red,
      // outline: Colors.red,
      error: Colors.red,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    disabledColor: AppColors.hintAndDisabledColor,
    hintColor: AppColors.hintAndDisabledColor,
    colorScheme: ColorScheme.dark(
      surface: AppColors.bgColorDark,
      surfaceDim: AppColors.dialogColorDark,
      onSurfaceVariant: AppColors.drawerTileColordark,
      primary: AppColors.primaryColor,
      secondary: AppColors.tertiaryColor,
      tertiary: AppColors.bgAiReplyDark,
      // onSurface: Colors.red,
      // outline: Colors.red,
      error: Colors.red,
    ),
  );
}
