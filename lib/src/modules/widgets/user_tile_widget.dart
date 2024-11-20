import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:flutter/material.dart';

class UserTileWidget extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const UserTileWidget({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppLiterArtTheme.violetFillDark,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            //foto do usuário
            const Icon(
              Icons.person,
              color: AppLiterArtTheme.violetButton,
            ),
            //nome
            Text(
              text,
              style: const TextStyle(color: AppLiterArtTheme.grey),
            )
          ],
        ),
      ),
    );
  }
}
