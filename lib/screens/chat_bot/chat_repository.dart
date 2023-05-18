import 'package:http/http.dart' as http;
import 'constant.dart';
import 'dart:convert';

Future<String> generateResponse(String prompt) async {
  const apiKey = "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";
  const endpoint =
      'https://api.openai.com/v1/engines/davinci-codex/completions';

  try {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'text-davinci-003',
        'prompt': prompt,
        'max_tokens': 2000,
        'temperature': 0,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['choices'][0]['text'];
    } else {
      throw Exception('Failed to generate response: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to generate response: $e');
  }
}
