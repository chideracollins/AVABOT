import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeData extends ChangeNotifier {
  final SharedPreferences prefs;

  ThemeModeData(this.prefs);

  ThemeMode get themeMode {
    final String? mode = prefs.getString("themeMode");
    switch (mode) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  void changeThemeMode(String mode) async {
    await prefs.setString("themeMode", mode);
    notifyListeners();
  }
}
