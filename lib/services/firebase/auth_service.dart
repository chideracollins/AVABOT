import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/shopping_cart.dart';
import '../../pages/login.dart';
import '../../pages/shop.dart';

class AuthService extends StatelessWidget {

  const AuthService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ChangeNotifierProvider(
                create: (context) => ShoppingCart(),
                child: const ShopPage(),
              );
            } else {
              return LoginPage();
            }
          }),
    );
  }

  // static User? get user => FirebaseAuth.instance.currentUser;

  

  // static void registerUser(
  //     {required String fullName,
  //     required String email,
  //     required String password}) async {
  //   try {
  //     final credential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     await credential.user?.updateDisplayName(fullName);
  //     signInUser(email: email, password: password);
  //   } catch (e) {
  //     Dialogs.errorDialog(_context);
  //   }
  // }

  // static void signOutUser() async {
  //   await FirebaseAuth.instance.signOut();
  // }

  // static void updateUserDetails({String? fullName, String? password}) async {
  //   if (user?.displayName != fullName) await user?.updateDisplayName(fullName);
  //   if (password != null) await user?.updatePassword(password);
  // }
}
