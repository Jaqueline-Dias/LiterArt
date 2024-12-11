import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:flutter/material.dart';

class BottomNavigatorAppBar extends StatelessWidget {
  const BottomNavigatorAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(
        Icons.arrow_back_ios_rounded,
        color: LAColors.buttonPrimary,
        size: 32,
      ),
    );
  }
}
