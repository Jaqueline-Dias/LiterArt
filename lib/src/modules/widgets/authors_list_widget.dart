import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:flutter/material.dart';

class AuthorsListWidget extends StatelessWidget {
  final List<String> currentAuthors;

  const AuthorsListWidget({
    super.key,
    required this.currentAuthors,
  });

  @override
  Widget build(BuildContext context) {
    String finalAuthors = 'Por';
    int totalAuthors = currentAuthors.length;
    if (totalAuthors > 1) {
      for (int idx = 0; idx < totalAuthors; idx++) {
        String author = currentAuthors[idx];
        if (idx == totalAuthors - 1) {
          finalAuthors += "e $author.";
        } else if (1 == totalAuthors - 1) {
          finalAuthors += "$author ";
        } else {
          finalAuthors += "$author, ";
        }
      }
      return Text(
        finalAuthors,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: AppLiterArtTheme.authorMobileDateStyle,
      );
    } else if (currentAuthors.length == 1) {
      return Text("Por ${currentAuthors[0]}.",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppLiterArtTheme.authorMobileDateStyle);
    } else {
      return const Text('Desconhecido',
          style: AppLiterArtTheme.authorMobileDateStyle);
    }
  }
}
