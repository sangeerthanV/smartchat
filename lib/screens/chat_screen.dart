import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../services/openai_service.dart';
import '../services/auth_service.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/input_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final OpenAIService _openAI = OpenAIService();
  final AuthService _authService = AuthService();

  void _sendMessage() async {
    final input = _controller.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _messages.add(Message(text: input, isUser: true));
    });
    _controller.clear();

    final reply = await _openAI.sendMessage(input);

    setState(() {
      _messages.add(Message(text: reply, isUser: false));
    });
  }

  void _logout() async {
    await _authService.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartChat'),
        actions: [
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) => ChatBubble(message: _messages[index]),
            ),
          ),
          InputField(controller: _controller, onSend: _sendMessage),
        ],
      ),
    );
  }
}
