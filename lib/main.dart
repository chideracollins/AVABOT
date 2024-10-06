import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import "models/theme_mode.dart";
import "pages/account.dart";
import "pages/card.dart";
import "pages/cart.dart";
import "pages/face_id.dart";
import "pages/fingerprint.dart";
import "pages/settings.dart";
import "services/auth.dart";
import "utils/themes/themes.dart";

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  return runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModeModel(),
      child: const Avabot(),
    ),
  );
}

class Avabot extends StatelessWidget {
  const Avabot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthService(),
      debugShowCheckedModeBanner: false,
      title: "Avabot",
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: Provider.of<ThemeModeModel>(context).themeMode,
      routes: {
        "/account": (context) => const AccountPage(),
        "/card": (context) => const CardPage(),
        "/cart": (context) => const CartPage(),
        "/face-id": (context) => const FaceIdPage(),
        "/fingerprint": (context) => const FingerPrintPage(),
        "/settings": (context) => const SettingsPage(),
      },
    );
  }
}
