import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String stepText;

  const CustomAppBar({super.key, required this.title, required this.stepText});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const BottomNavigatorAppBar(),
      title: Text(
        title,
        style: LAAppTheme.textInfoAppBar,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Text(
            stepText,
            style: LAAppTheme.textInfoAppBar,
          ),
        ),
      ],
    );
  }

  // Define the preferredSize for the app bar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
