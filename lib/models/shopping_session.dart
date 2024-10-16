import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

import 'gemini_response.dart';
import '../services/gemini.dart';
import 'user_question.dart';

class ShoppingSession extends ChangeNotifier {
  late Map<UserQuestion, GeminiResponse?>? history;
  final ChatSession chat;

  ShoppingSession(this.chat);

  void userRequest({String? question, XFile? attachedImage}) async {
    if (question == null && attachedImage == null) return;

    final UserQuestion userQuestion =
        UserQuestion(question: question, attachedImage: attachedImage);
    history?[userQuestion] = null;
    notifyListeners();

    history?[userQuestion] = await Gemini.generateReply(chat, userQuestion);
    notifyListeners();
  }
}
