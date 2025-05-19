import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String _apiKey = 'AIzaSyCH9jZpt5rCKQKZ6wkcnteK-tEH7vttdeU';
  final String _projectId = 'smartchat-b9dcc';       // e.g., smartchat-12345
  final String _location = 'us-central1';            // your model's region
  final String _modelId = 'chat-bison-001';          // exact model ID you have access to

  Future<String> sendMessage(String message) async {
    final url = 'https://generativelanguage.googleapis.com/v1beta2/projects/$_projectId/locations/$_location/models/$_modelId:generateMessage?key=$_apiKey';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "prompt": {
          "messages": [
            {"author": "user", "content": message}
          ]
        },
        "temperature": 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final reply = data['candidates'][0]['content'];
      return reply.trim();
    } else {
      return 'Error: ${response.statusCode} - ${response.body}';
    }
  }
}
