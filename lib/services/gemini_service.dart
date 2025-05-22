import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String _apiKey = 'AIzaSyCH9jZpt5rCKQKZ6wkcnteK-tEH7vttdeU'; // your Gemini API key

  Future<String> sendMessage(String userMessage) async {
    const String url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

    final response = await http.post(
      Uri.parse('$url?key=$_apiKey'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': userMessage}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final reply = data['candidates'][0]['content']['parts'][0]['text'];
      return reply.trim();
    } else {
      print('API Error: ${response.statusCode}');
      print('Response: ${response.body}');
      return 'Error from Gemini API';
    }
  }
}
