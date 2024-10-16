import 'package:firebase_core/firebase_core.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter/material.dart";
import "package:google_generative_ai/google_generative_ai.dart";
import 'package:provider/provider.dart';
import "package:shared_preferences/shared_preferences.dart";

import "models/shopping_session.dart";
import "models/theme_mode_data.dart";
import "pages/account.dart";
import "pages/bank_card.dart";
import "pages/cart.dart";
import "pages/face_id.dart";
import "pages/fingerprint.dart";
import "services/firebase/auth_service.dart";
import "services/firebase/firebase_options.dart";
import "services/gemini.dart";
import "utils/themes/themes.dart";

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  final String apiKey = dotenv.env["API_KEY"]!;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final ChatSession chat = Gemini.createChatSession(apiKey);
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeModeData(prefs),
      ),
      ChangeNotifierProvider(
        create: (_) => ShoppingSession(chat),
      ),
    ],
    child: const Avabot(),
  ));
}

class Avabot extends StatelessWidget {
  const Avabot({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeData>(
      builder: (context, modelInstance, child) {
        return MaterialApp(
          home: AuthService(),
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
          },
        );
      },
    );
  }
}
