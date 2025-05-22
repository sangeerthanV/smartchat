

import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
final String apiKey = 'AIzaSyCH9jZpt5rCKQKZ6wkcnteK-tEH7vttdeU'; // Replace this

Future<String> sendMessage(String message) async {
final url = Uri.parse(
'https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent=$apiKey');

final response = await http.post(url,
headers: {'Content-Type': 'application/json'},
body: jsonEncode({
"contents": [
{
"parts": [{"text": message}]
}
]
}));

if (response.statusCode == 200) {
final data = jsonDecode(response.body);
return data['candidates'][0]['content']['parts'][0]['text'];
} else {
return 'API Error: ${response.body}';
}
}
}
