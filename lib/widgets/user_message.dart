import 'package:flutter/material.dart';

class UserMessage extends StatelessWidget {
  final String? message;
  final String? imageUrl;
  const UserMessage(this.message, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (imageUrl != null)
              Padding(
                padding: imageUrl != null && message != null
                    ? const EdgeInsets.only(bottom: 8.0)
                    : const EdgeInsets.only(bottom: 0),
                child: Image.network(
                  imageUrl!,
                  width: MediaQuery.of(context).size.width * 0.6,
                  fit: BoxFit.cover,
                ),
              ),
            if (message != null)
              Container(
                padding: const EdgeInsets.all(8),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Text(
                  message!,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
          ],
        ));
  }
}
