import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiAPIService {
  static const String _baseUrl =
      'https://api.anthropic.com/v1'; // Replace with the actual API base URL
  static const String _apiKey = 'Your_API_Key';
  Future<String?> sendMessage(List<String>previousMessages,String newMessage) async {


    // For text-only input, use the gemini-pro model
    final model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: _apiKey,
        generationConfig: GenerationConfig(maxOutputTokens: 2000));
    // Initialize the chat
    List<Content> Mess=[];
    for(int i=0;i<previousMessages.length;i++){
      if(i%2==0)
      Mess.add(Content.text(previousMessages[i]));
      else
        Mess.add(Content.model([TextPart(previousMessages[i])]));
    }

    final chat = model.startChat(history: Mess);
    var content = Content.text(newMessage );
    var response = await chat.sendMessage(content );
    final output=response.text;
    return output ?? '';
  }
}
