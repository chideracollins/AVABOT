import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/constants/images.dart';

class DefaultShopInterface extends StatelessWidget {
  const DefaultShopInterface({super.key});

  User? get user => FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Images.launcherIcon),
          Text.rich(
            TextSpan(
              text: user?.displayName,
              children: [
                TextSpan(
                  text: "Ava!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: "Your ",
              children: [
                TextSpan(
                  text: "AI assistant ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const TextSpan(
                  text:
                      "for you seamless online shopping experience. I'm glad you are here. ",
                ),
              ],
            ),
          ),
          Text(
            "Welcome to Avabot!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
