// import "package:google_generative_ai/google_generative_ai.dart";


// Future<String?> generateAiReply(String question) async {
//     final model =
//         GenerativeModel(model: "gemini-1.5-flash-latest", apiKey: apiKey);
//     final content = [Content.text(question)];
//     try {
//       final response = await model.generateContent(content);
//       return response.text;
//     } on Exception catch (e) {
//       return "Sorry we couldn't access Gemini due to this error '${e.runtimeType}', check your internet connection and try again.";
//     }
//   }