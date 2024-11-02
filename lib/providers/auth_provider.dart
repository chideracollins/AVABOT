import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _email;
  String? _name;

  String? get email => _email;
  String? get name => _name;

  void setUser(String email, String name) {
    _email = email;
    _name = name;
    notifyListeners();
  }

  void clearUser() {
    _email = null;
    _name = null;
    notifyListeners();
  }
}
