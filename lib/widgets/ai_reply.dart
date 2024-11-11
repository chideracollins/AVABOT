import 'package:avabot/models/shopping_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '../models/gemini_response.dart';
import '../utils/constants/images.dart';

class AiReply extends StatefulWidget {
  final GeminiResponse response;

  const AiReply(this.response, {super.key});

  @override
  State<AiReply> createState() => _AiReplyState();
}

class _AiReplyState extends State<AiReply> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: CircleAvatar(
                child: Image.asset(
                  Images.launcherIcon,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0.0, 0.0),
              child: Text(
                "Avabot",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(52.0, 24.0, 0.0, 0.0),
          child: Expanded(
            child: MarkdownBody(
              data: Provider.of<ShoppingSession>(context)
                      .lastAiResponse
                      ?.response ??
                  "Nothing to show here yet.",
            ),
          ),
        ),
      ],
    );
  }
}