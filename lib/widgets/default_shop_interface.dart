import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/constants/images.dart';

class DefaultShopInterface extends StatelessWidget {
  const DefaultShopInterface({super.key});

  User? get user => FirebaseAuth.instance.currentUser;

  String getFirstName() {
    // Extract only the first name if displayName is available
    return user?.displayName?.split(' ').first ?? 'there';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Display app icon or logo
          Image.asset(
            Images.launcherIcon,
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 20), // Add space after the icon

          // Personalized greeting text with user's first name and "Ava" in green
          Text.rich(
            TextSpan(
              text: "Hi ${getFirstName()}, I'm ",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: "Ava!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10), // Space after greeting

          // Introduction of Ava's role
          Text.rich(
            TextSpan(
              text: "Your ",
              style: const TextStyle(fontSize: 16),
              children: [
                TextSpan(
                  text: "AI assistant ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                const TextSpan(
                  text:
                      "for a seamless online shopping experience. I'm glad you're here!",
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20), // Space before "Welcome" text

          // Welcome text
          Text(
            "Welcome to Avabot!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
