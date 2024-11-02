import 'package:flutter/material.dart';

import '../../constants/colors.dart';

final TextStyle _headingText = TextStyle(
  color: AppColors.primaryColor,
  fontWeight: FontWeight.w800,
);

class TextThemes {
  TextThemes._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      color: AppColors.primaryColor,
      fontSize: 23.0,
      fontWeight: FontWeight.w600,
      height: 28.04,
    ),
    displayMedium: TextStyle(
      color: AppColors.infoTextColor,
      fontSize: 19.0,
      fontWeight: FontWeight.w600,
      height: 20.0,
      letterSpacing: 0.02,
    ),
    headlineLarge: _headingText.copyWith(
      fontSize: 24.0,
      height: 29.05,
      letterSpacing: 0.01,
    ),
    headlineMedium: _headingText.copyWith(
      fontSize: 16.0,
      height: 19.36,
      letterSpacing: 0.005,
    ),
    bodyLarge: TextStyle(
      color: AppColors.infoTextColor,
      fontSize: 13.0,
      fontWeight: FontWeight.w500,
      height: 15.85,
    ),
    bodyMedium: TextStyle(
      color: AppColors.tertiaryColor,
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      height: 14.52,
    ),
    bodySmall: TextStyle(
      color: AppColors.infoTextColor,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      height: 16.0,
      letterSpacing: 0.01,
    ),
    titleLarge: TextStyle(
      color: AppColors.tertiaryColor,
      fontSize: 12.0,
      fontWeight: FontWeight.w700,
      height: 14.52,
    ),
    labelLarge: TextStyle(
      color: AppColors.onSecondaryAndCardColor,
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      height: 16.94,
    ),
    labelMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      height: 20.0,
      letterSpacing: 0.01,
    ),
  );

  static TextTheme darkTextTheme = TextTheme();
}
