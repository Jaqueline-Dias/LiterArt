import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetConatinerBookshelf extends StatelessWidget {
  const WidgetConatinerBookshelf(
      {super.key,
      required this.onTap,
      required this.title,
      required this.image});

  final VoidCallback onTap;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppLiterArtTheme.violetLigth2,
                width: 1, // Define a cor e largura da borda
              ),
            ),
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              image,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          title,
        ),
      ],
    );
  }
}
