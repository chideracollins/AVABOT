import 'package:flutter/material.dart';

class UserMessage extends StatelessWidget {
  final String message;
  const UserMessage(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 250,
      padding: const EdgeInsets.all(8),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: Text(
        message,
        softWrap: true,
        // maxLines: 10,
        overflow: TextOverflow.visible,
        style: TextStyle(
          color: Colors.grey.shade200,
        ),
      ),
    );
  }
}
