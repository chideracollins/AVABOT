import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  final String message;

  const MessageDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog();
  }
}
