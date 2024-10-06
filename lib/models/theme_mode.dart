import 'package:flutter/material.dart';

class ThemeModeModel extends ChangeNotifier {

  ThemeMode themeMode = ThemeMode.system;

  void setSystem(){
    themeMode = ThemeMode.system;
    notifyListeners();
  }  
  void setLight(){
    themeMode = ThemeMode.light;
    notifyListeners();
  }  
  void setDark(){
    themeMode = ThemeMode.dark;
    notifyListeners();
  }
}
