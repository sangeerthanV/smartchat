import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const InputField({super.key, required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Type a message...'),
            ),
          ),
          IconButton(icon: const Icon(Icons.send), onPressed: onSend),
        ],
      ),
    );
  }
}
