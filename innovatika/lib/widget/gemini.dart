import 'dart:async';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiClient {
  GeminiClient({
    required this.model,
  });

  String model;

  String outputText = '';

  Future generateContentFromText({
    required String prompt,
  }) async {
    await dotenv.load(fileName: 'assets/env/data.env');
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    final geminiModel =
        GenerativeModel(model: model, apiKey: apiKey.toString());
    final response = await geminiModel.generateContent([Content.text(prompt)]);
    return response.text;
  }

  String extractCodeBlock(String text) {
    int startIndex = text.indexOf('```json');
    if (startIndex == -1) {
      return '';
    }
    int endIndex = text.indexOf('```', startIndex + 3);
    if (endIndex == -1) {
      return '';
    }

    return text.substring(startIndex + 3 + 4, endIndex);
  }
}

// Example 
// String customPrompt = "My location is ${textFieldController.text} analyse the real time climate and wether conditions and give me the common type of soil that is found in that region also export the data in the form of json which i can use in flutter to show this data to user in form of UI , also export is so that it only shows the json and no other text so that its easy to use extract data from";
// GeminiClient geminiClient =
//     GeminiClient(model: "gemini-1.5-flash-latest");
// dynamic output = await geminiClient.generateContentFromText(
//     prompt: customPrompt);