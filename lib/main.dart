import 'package:flutter/material.dart';
import 'auth/login.dart';
import 'pages/dashboard.dart';
import 'pages/shop.dart';
import 'pages/account.dart';

void main() {
  return runApp(const Avabot());
}

class Avabot extends StatelessWidget {
  const Avabot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Login(),
      debugShowCheckedModeBanner: false,
      title: const String.fromEnvironment("Avabot", defaultValue: "Avabot"),
      routes: {
        "/dashboard": (context) => const Dashboard(),
        "/shop": (context) => const Shop(),
        "/account": (context) => const Account(),
      },
    );
  }
}
