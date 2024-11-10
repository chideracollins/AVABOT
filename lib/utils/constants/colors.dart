import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color bgColor = Colors.white;
  static Color bgColorDark = const Color.fromARGB(255, 27, 27, 27);
  static Color dialogColor = Colors.grey.shade100;
  static Color dialogColorDark = const Color.fromARGB(255, 40, 40, 40);
  static Color drawerTileColor = Colors.grey.shade700;
  static Color drawerTileColordark = Colors.white;
  static Color primaryColor = const Color.fromRGBO(1, 241, 35, 1);
  static Color tertiaryColor = const Color.fromRGBO(7, 151, 186, 1);
  static Color infoTextColor = const Color.fromRGBO(113, 114, 122, 1);
  static Color shadowColor = const Color.fromRGBO(116, 212, 130, 0.49);
  static Color hintAndDisabledColor = const Color.fromRGBO(143, 144, 152, 1);
  static Color onSecondaryAndCardColor = const Color.fromRGBO(31, 32, 36, 1);

  static Color secondaryColor =
      const Color.fromRGBO(248, 249, 254, 1); // For Avabot reply widget

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
