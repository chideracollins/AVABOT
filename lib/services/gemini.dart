import "package:google_generative_ai/google_generative_ai.dart";

import '../models/gemini_response.dart';
import '../models/product.dart';
import '../models/user_question.dart';
import 'dummy_json.dart';

class Gemini {
  Gemini._();

  static const String _categories =
      "beauty, fragrances, furniture, groceries, home-decoration, kitchen-accessories, laptops, mens-shirts, mens-shoes, mens-watches, mobile-accessories, motorcycle, skin-care, smartphones, sports-accessories, sunglasses, tablets, tops, vehicle, womens-bags, womens-dresses, womens-jewellery, womens-shoes, womens-watches";

  static const String _systemInstruction =
      "You are the sales representative for an online store, named avabot. Users can shop from this store by interacting with you, and you are to reply respectfully for each user's request. However never reply to any user's request that has nothing to do with shopping or does not show user's interest in shopping or getting to know more about avabot, always politely decline such requests. In order to assist you in this role, as avabots' sales representative, each user's request will be accompanied with a set of instructions to guide you through the efficient resolution of user's request. This resolution of user's request will be achieved systematically through a series of interactions, each with it's own set of instructions. Do follow the istructions for each interaction judiciously and never disobey any.";
  static const String _firstPromptInstruction =
      "Here is a request from user. Go through the request and understand it, it could be just text or an image or both. If the request does not in any way show that user may be interested in shopping from avabot or in getting to know more about avabot, reply with the word 'none' only. However if the request indicates user's interest in shopping from us in any way and you would want to make a search in avabot's database to find what's available as it relates to user's request, respond with a whitespace separated list of url patterns for use in making a database search which will be returned to you in the next prompt. Here is a numbered guide on how to make the url pattern: 1) if you would like to get a list of available products, include, '/products', by default this returns the first 30 items in the database. 2) To search for a specific product, include, '/products/search?q=<specific-product>', replace <specific-product> with the product name you would want to search for, e.g '/products/search?q=phone'. 3) You can pass limit and skip params to limit and skip the results, e.g '/products?limit=10&skip=10', use limit=0 to get all items. 4) You can get products by their category, to do this, include, '/products/category/<category>', replace <category> with the specific category name, here is a list of available categories, $_categories. Please make sure that the information you expect from these url patterns will help you in answering the user, else do not include any pattern that wouldn't be useful. Otherwise, if there's no need to make a search in database, still reply with the one word, 'none' only. The user request: ";
  static const String _quickResponseInstruction =
      "Now reply user appropriately.";
  static const String _secondPromptInstruction =
      "Here is a Json formatted numbered list of obtained database search results, now with this information, look through it and select every product that matches user's request and reply with a whitespace separated list of their id field's. Make sure not to select more than 10 products. Again you are to return for each product it's id field, nothing more, nothing less. Make it a list of the selected products, separating each id from the other with a whitespace like I already said. e.g '1 3 55 67'. The search results: ";
  static const String _thirdPromptInstruction =
      "Now clearfully reply user, taking into account, the products, you selected for display to user and user's request.";

  static ChatSession createChatSession(String apiKey) {
    final model = GenerativeModel(
        model: "gemini-1.5-flash-latest",
        apiKey: apiKey,
        systemInstruction: Content.system(_systemInstruction));
    return model.startChat();
  }

  static Future<Content> _createPrompt(
      UserQuestion userQuestion, String instruction) async {
    List<Part> content = [TextPart(instruction)];

    if (userQuestion.question != null) {
      content.add(TextPart(userQuestion.question!));
    }
    if (userQuestion.attachedImage != null) {
      final attachedImage = userQuestion.attachedImage!;
      content.add(DataPart(attachedImage.mimeType ?? 'image/jpeg',
          await attachedImage.readAsBytes()));
    }

    return Content.multi(content);
  }

  static Future<GeminiResponse> generateReply(
      ChatSession chat, UserQuestion userQuestion) async {
    final Content firstPrompt =
        await _createPrompt(userQuestion, _firstPromptInstruction);

    GenerateContentResponse firstResponse = await chat.sendMessage(firstPrompt);

    if (firstResponse.text == "none") {
      final quickResponse =
          await chat.sendMessage(Content.text(_quickResponseInstruction));
      return GeminiResponse(
          response: quickResponse.text ??
              "Sorry, we are having server overload currently.");
    } else {
      List<String>? searches = firstResponse.text?.split(" ");
      if (searches != null) {
        String? dummyJson = await DummyJson.search(searches);
        if (dummyJson == null) {
          final quickResponse = await chat.sendMessage(Content.text(
              "Unfortunately the database query didn't return anything. $_quickResponseInstruction"));
          return GeminiResponse(response: quickResponse.text ?? "Try again.");
        }
        final secondResponse = await chat
            .sendMessage(Content.text(_secondPromptInstruction + dummyJson));
        List<String>? productsId = secondResponse.text?.split(" ");
        final thirdResponse =
            await chat.sendMessage(Content.text(_thirdPromptInstruction));
        List<Product>? products = await DummyJson.getProducts(productsId);
        return GeminiResponse(
            response: thirdResponse.text ??
                "Something went wrong during the generation of the response.",
            products: products);
      }
      return GeminiResponse(
          response: "Sorry we couldn't process your request.");
    }
  }
}
