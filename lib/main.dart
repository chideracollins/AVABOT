import "package:flutter_dotenv/flutter_dotenv.dart";

import 'package:flutter/material.dart';

import 'pages/dashboard.dart';
import 'pages/shop.dart';
import 'pages/account.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  return runApp(const Avabot());
}

class Avabot extends StatelessWidget {
  const Avabot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Dashboard(),
      debugShowCheckedModeBanner: false,
      title: const String.fromEnvironment("Avabot", defaultValue: "Avabot"),
      routes: {
        "/shop": (context) => const Shop(),
        "/account": (context) => const Account(),
      },
    );
  }
}
