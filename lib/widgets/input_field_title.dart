import 'package:flutter/material.dart';

class InputFieldTitle extends StatelessWidget {
  /// Provide the title to be displayed.
  final String title;
  const InputFieldTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
