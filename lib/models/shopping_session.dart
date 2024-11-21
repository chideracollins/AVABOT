import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/avabot_backend.dart';
import 'gemini_response.dart';
import 'user_question.dart';

class ShoppingSession extends ChangeNotifier {
  late Map<UserQuestion, GeminiResponse> history = {};

  ShoppingSession();

  bool get hastStarted {
    return history.isNotEmpty == true ? true : false;
  }

  Future<void> userRequest({String? question, XFile? attachedImage}) async {
    if (question == null && attachedImage == null) return;

    final UserQuestion userQuestion =
        UserQuestion(question: question, attachedImage: attachedImage);

    history[userQuestion] = await AvabotBackend.reply(userQuestion);
    notifyListeners();
  }
}
