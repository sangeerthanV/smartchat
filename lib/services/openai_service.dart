import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String _apiKey = 'YOUR_OPENAI_API_KEY';

  Future<String> sendMessage(String message) async {
    const url = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": "Reply in the same language. You can understand English, Tamil, and Sinhala."},
          {"role": "user", "content": message},
        ],
        "temperature": 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final reply = data['choices'][0]['message']['content'];
      return reply.trim();
    } else {
      return 'Error: ${response.body}';
    }
  }
}
