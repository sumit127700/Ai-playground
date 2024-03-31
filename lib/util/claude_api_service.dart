import 'dart:convert';
import 'package:http/http.dart' as http;


class ClaudeAPIService {
  static const String _baseUrl = 'https://api.anthropic.com/v1'; // Replace with the actual API base URL
  static const String _apiKey = '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'; // Replace with your actual API key

  Future<String> sendMessage(String message) async {
    try{
      final url = Uri.parse('https://api.anthropic.com/v1/messages');
      final headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $_apiKey',
        'anthropic-version': '2023-06-01',
        'x-api-key': _apiKey
      };
      final body = jsonEncode({
        "model": "claude-3-opus-20240229",
        "max_tokens": 1024,
        "messages":[
          {"role": "user", "content": message}
        ]
      });
      print('response sending');
      final response = await http.post(url, headers: headers, body: body);
      print(response.body);
      print('response send');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['content'][0]['text'];
      } else {
        throw Exception('Failed to get response from Claude API');
      }
    }catch(e){
      print(e);
      return "error ocurred";
    }
  }
}