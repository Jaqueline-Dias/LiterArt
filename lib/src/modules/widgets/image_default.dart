import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageDefault extends StatelessWidget {
  const ImageDefault({
    super.key,
    required this.imageDeafult,
    required this.textInfo1,
    required this.textInfo2,
  });
  final String imageDeafult;
  final String textInfo1;
  final String textInfo2;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(imageDeafult),
            const SizedBox(height: 20),
            Text(textInfo1, style: AppLiterArtTheme.textInfoSearch),
            Text(textInfo2, style: AppLiterArtTheme.textInfoSearch),
          ],
        ),
      ),
    );
  }
}
