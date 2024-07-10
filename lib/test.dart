// import "package:google_generative_ai/google_generative_ai.dart";

// const apiKey = "AIzaSyDTwm_NNQo82hGlr8juULY5ee7uYrHHhYU";
// String? rpl;

// Future<String?> generateAiReply(String question) async {
//   final model =
//       GenerativeModel(model: "gemini-1.5-flash-latest", apiKey: apiKey);
//   final content = [Content.text(question)];
//   try {
//     final response = await model.generateContent(content);
//     return response.text;
//   } on Exception catch (e) {
//     return "null - $e";
//   }
// }

// void main() async {
//   var rpl = generateAiReply("Hello");
//   await Future.delayed(const Duration(seconds: 10));
//   print(await rpl);
//   // while (rpl == null) {
//   //   print("inside - $rpl");
//   //   continue;
//   // }
//   // print("\n\nDone");
//   // print(rpl.toString());
// }
