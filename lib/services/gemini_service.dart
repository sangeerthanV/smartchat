import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String _apiKey = 'AIzaSyCH9jZpt5rCKQKZ6wkcnteK-tEH7vttdeU'; // your Gemini API key

  Future<String> sendMessage(String message) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$_apiKey',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": message}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'].toString();
      } else {
        print('❌ API Error: ${response.body}');
        return 'API Error: ${response.statusCode}';
      }
    } catch (e) {
      print('❌ Exception: $e');
      return 'Failed to connect to Gemini API';
    }
  }
}
