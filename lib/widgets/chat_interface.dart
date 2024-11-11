import 'package:flutter/material.dart';
// import "package:flutter_markdown/flutter_markdown.dart";
import 'package:provider/provider.dart';

import '../models/shopping_session.dart';
import 'ai_reply.dart';
// import '../utils/constants/images.dart';

class ChatInterface extends StatefulWidget {
  const ChatInterface({super.key});

  @override
  State<ChatInterface> createState() => _ChatInterfaceState();
}

class _ChatInterfaceState extends State<ChatInterface> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
          itemCount: Provider.of<ShoppingSession>(context).historyCount,
          itemBuilder: (context, index) {
            List chatHistorykeys =
                Provider.of<ShoppingSession>(context).history.keys.toList();
            List chatHistoryValues =
                Provider.of<ShoppingSession>(context).history.values.toList();
            return Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [Text(chatHistorykeys[index].question)],
                ),
                AiReply(chatHistoryValues[index]),
              ],
            );
          },
        ),
      ),
    );
  }
}
