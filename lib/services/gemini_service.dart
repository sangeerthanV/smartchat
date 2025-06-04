import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String _apiKey = '';

  Future<String> sendMessage(String userMessage) async {
    const String baseUrl = '';
    final Uri url = Uri.parse('$baseUrl?key=$_apiKey');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
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
      final jsonResponse = jsonDecode(response.body);
      final reply = jsonResponse['candidates'][0]['content']['parts'][0]['text'];
      return reply;
    } else {
      print('API Error: ${response.statusCode}');
      print('Message: ${response.body}');
      return 'Error from Gemini API: ${response.statusCode}';
    }
  }
}
