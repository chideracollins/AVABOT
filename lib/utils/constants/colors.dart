import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color primaryColor = Color.fromRGBO(1, 241, 35, 1);
  static Color tertiaryColor = Color.fromRGBO(7, 151, 186, 1);
  static Color infoTextColor = Color.fromRGBO(113, 114, 122, 1);
  static Color shadowColor = Color.fromRGBO(116, 212, 130, 0.49);
  static Color hintAndDisabledColor = Color.fromRGBO(143, 144, 152, 1);
  static Color onSecondaryAndCardColor = Color.fromRGBO(31, 32, 36, 1);

  static Color secondaryColor =
      Color.fromRGBO(248, 249, 254, 1); // For Avabot reply widget

  static Gradient buttonLinearGradient =
      LinearGradient(colors: [tertiaryColor, primaryColor]);

  static Gradient cardLinearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(7, 151, 186, 0.2),
      Color.fromRGBO(1, 241, 35, 0.2),
    ],
  );
}
