import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble ({super.key, required this.text, required this.isSender});
  final String text;
  final bool isSender;
  @override
  Widget build(BuildContext context) {
    return
      Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: isSender ? Colors.pinkAccent.withOpacity(0.2) : Colors.grey[200],
            borderRadius: isSender
                ? const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            )
                : const BorderRadius.only(
              topRight: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
              topLeft: Radius.circular(15.0),
            ),
          ),
          child: Text(
              text,
              style: const TextStyle(fontSize: 16.0)),
        ),
      );
  }
}
