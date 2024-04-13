import 'dart:convert';
import 'package:http/http.dart' as http;


class ChatGptApiService {
  // Replace with the actual API base URL
// Replace with your actual API key

  final List<Map<String, String>> messages = [];
  String OpenAiKey = 'API_KEY_WITH_BALANCE';

  Future<String> sendMessage(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $OpenAiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );

      if (res.statusCode == 200) {
        String content =
        jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }
      print(res.statusCode);
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
}
