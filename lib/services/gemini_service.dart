
  import 'dart:convert';
  import 'package:http/http.dart' as http;

  class GeminiService {
  final String _apiKey = 'AIzaSyCAryYstoEg7wim4zx_bRTXeDx2bgukpek'; // Replace with your valid Gemini API key

  Future<String> sendMessage(String userMessage) async {
  const String baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';
  final Uri url = Uri.parse('$baseUrl?key=$_apiKey');

  try {
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
  if (jsonResponse['candidates'] != null &&
  jsonResponse['candidates'].isNotEmpty &&
  jsonResponse['candidates'][0]['content']['parts'].isNotEmpty) {
  final reply = jsonResponse['candidates'][0]['content']['parts'][0]['text'];
  return reply;
  } else {
  return 'No reply from Gemini.';
  }
  } else {
  print('API Error: ${response.statusCode}');
  print('Message: ${response.body}');
  return 'Error from Gemini API: ${response.body}';
  }
  } catch (e) {
  print('Exception: $e');
  return 'Error sending message to Gemini API.';
  }
  }
  }
