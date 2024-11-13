import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/constants/colors.dart';

class AccountDialog extends StatelessWidget {
  User? get user => FirebaseAuth.instance.currentUser;
  const AccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      contentPadding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user?.displayName ?? 'John Doe',
            style: const TextStyle(fontSize: 20.0),
          ),
          Text(user?.email ?? 'No email available'),
          const SizedBox(height: 8.0),
          const Divider(height: 20.0, thickness: 1.0),
        ],
      ),
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      actions: [
        TextButton(
          onPressed: () async {
            await _logout(context);
          },
          child: Text(
            'Logout',
            style: TextStyle(color: AppColors.warningColor),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
