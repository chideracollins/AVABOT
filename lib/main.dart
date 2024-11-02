import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'auth/auth_redirect.dart';
import 'pages/dashboard.dart';
import 'pages/shop.dart';
import 'pages/account.dart';
import 'auth/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const Avabot(),
    ),
  );
}

class Avabot extends StatelessWidget {
  const Avabot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AuthRedirect(),
      debugShowCheckedModeBanner: false,
      title: const String.fromEnvironment("Avabot", defaultValue: "Avabot"),
      routes: {
        "/dashboard": (context) => const Dashboard(),
        "/shop": (context) => const Shop(),
        "/account": (context) => const Account(),
        "/signup": (context) => const Signup(),
      },
    );
  }
}
