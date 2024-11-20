import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:flutter/material.dart';

class ChatBubbleWidget extends StatelessWidget {
  final String message;
  final bool isCurrent;

  const ChatBubbleWidget(
      {super.key, required this.message, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isCurrent
              ? AppLiterArtTheme.chatSender
              : AppLiterArtTheme.chatReceiver,
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Text(
        message,
        style:
            TextStyle(color: isCurrent ? AppLiterArtTheme.grey : Colors.white),
      ),
    );
  }
}
