import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import "package:shared_preferences/shared_preferences.dart";

import 'firebase_options.dart';
import 'auth/auth_redirect.dart';
import 'auth/signup.dart';
import "models/shopping_cart.dart";
import "models/shopping_session.dart";
import "models/theme_mode_data.dart";
import "pages/account.dart";
import "pages/bank_card.dart";
import "pages/cart.dart";
import "pages/face_id.dart";
import "pages/fingerprint.dart";
import "utils/themes/themes.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeModeData(prefs),
        ),
        ChangeNotifierProvider(
          create: (_) => ShoppingCart(),
        ),
        ChangeNotifierProvider(
          create: (_) => ShoppingSession(),
        ),
      ],
      child: const Avabot(),
    ),
  );
}

class Avabot extends StatelessWidget {
  const Avabot({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeData>(builder: (context, modelInstance, child) {
      return MaterialApp(
        home: const AuthRedirect(),
        debugShowCheckedModeBanner: false,
        title: "Avabot",
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: modelInstance.themeMode,
        routes: {
          "/account": (context) => const AccountPage(),
          "/card": (context) => const CardPage(),
          "/cart": (context) => const CartPage(),
          "/face-id": (context) => const FaceIdPage(),
          "/fingerprint": (context) => const FingerPrintPage(),
          "/signup": (context) => const Signup(),
        },
      );
    });
  }
}
