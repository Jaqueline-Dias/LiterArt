import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  final String title;
  final bool? color;

  const TextTitle({required this.title, super.key, this.color = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: color == true
                  ? AppLiterArtTheme.grey
                  : AppLiterArtTheme.violetDark),
        ),
      ),
    );
  }
}
