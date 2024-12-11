import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:flutter/material.dart';

class LAWidgetPhraseBook extends StatelessWidget {
  const LAWidgetPhraseBook({
    super.key,
    required this.text,
    required this.book,
    required this.author,
  });

  final String text;
  final String book;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          text,
          textAlign: TextAlign.right,
          style: LAAppTheme.titleSplash,
        ),
        const SizedBox(height: 8),
        Text(
          book,
          textAlign: TextAlign.right,
          style: LAAppTheme.subTitleSplash,
        ),
        const SizedBox(height: 8),
        Text(
          '- $author',
          textAlign: TextAlign.right,
          style: LAAppTheme.subtitleSplsh,
        ),
      ],
    );
  }
}
