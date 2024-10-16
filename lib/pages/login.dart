// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/constants/images.dart';

// import '../widgets/dialogs/message_dialog.dart';
// import '../widgets/dialogs/sign_in_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // void _showErrorMessage(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => MessageDialog(message: message),
  //   );
  // }

  // void signInUser() async {
  //   showDialog(
  //     context: context,
  //     builder: (context) => SignInDialog(),
  //     barrierDismissible: false,
  //   );
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailController.text, password: passwordController.text);
  //     // ignore: use_build_context_synchronously
  //     if (context.mounted) Navigator.pop(context);
  //   } on FirebaseAuthException catch (e) {
  //     if (context.mounted) {
  //       switch (e.code) {
  //         case "value":
  //           _showErrorMessage(e.message);
  //           break;
  //         default:
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [Image.asset(Images.deliveryRobot)],
        ),
      ),
    );
  }
}
