import 'package:flutter/material.dart';

import '../services/avabot_backend.dart';
import 'gemini_response.dart';
import 'user_question.dart';

class ShoppingSession extends ChangeNotifier {
  late Map<UserQuestion, GeminiResponse> history = {};
  Map<String, String>? serializedHistory;

  ShoppingSession();

  bool get hasStarted {
    return history.isNotEmpty == true ? true : false;
  }

  Future<void> userRequest({String? question, String? attachedImage}) async {
    final UserQuestion userQuestion =
        UserQuestion(question: question, imageUrl: attachedImage);
    final (geminiResponse, newSerializedHistory) =
        await AvabotBackend.reply(userQuestion, serializedHistory);
    history[userQuestion] = geminiResponse;
    serializedHistory = newSerializedHistory;
    notifyListeners();
  }
}
