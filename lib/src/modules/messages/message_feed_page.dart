import 'package:flutter/material.dart';

class MessageFeedPage extends StatefulWidget {
  const MessageFeedPage({super.key});

  @override
  State<MessageFeedPage> createState() => _MessageFeedPageState();
}

class _MessageFeedPageState extends State<MessageFeedPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Página do chat'),
    );
  }
}
