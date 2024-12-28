import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class LAIconButtonAppBar extends StatelessWidget {
  const LAIconButtonAppBar({super.key});

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
