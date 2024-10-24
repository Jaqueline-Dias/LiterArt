import 'package:flutter/material.dart';

class FeedMessagePage extends StatefulWidget {
  const FeedMessagePage({super.key});

  @override
  State<FeedMessagePage> createState() => _FeedMessagePageState();
}

class _FeedMessagePageState extends State<FeedMessagePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Página do chat'),
    );
  }
}
