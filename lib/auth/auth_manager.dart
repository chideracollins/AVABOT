import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../providers/auth_provider.dart' as my_auth;
import 'package:provider/provider.dart';

class AuthManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(
      BuildContext context, String email, String password, String name) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Provider.of<my_auth.AuthProvider>(context, listen: false)
          .setUser(email, name);
    } catch (e) {
      print('Signup failed: $e');
    }
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        Provider.of<my_auth.AuthProvider>(context, listen: false)
            .setUser(email, "");
      }
    } catch (e) {
      print('Login failed: $e');
    }
  }

  Future<void> logout(BuildContext context) async {
    await _auth.signOut();
    Provider.of<my_auth.AuthProvider>(context, listen: false).clearUser();
  }
}
