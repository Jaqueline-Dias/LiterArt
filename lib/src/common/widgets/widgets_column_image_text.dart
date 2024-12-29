import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/core/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LAColumnImageText extends StatelessWidget {
  const LAColumnImageText(
      {super.key,
      required this.svgImage,
      required this.title,
      required this.subTitle});

  final String svgImage;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(LASizes.defaultSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgImage,
            height: LASizes.imageThumbSize2,
          ),
          const SizedBox(height: LASizes.lg),
          Text(
            title,
            style: LATextTheme.lightTextTheme.headlineSmall,
          ),
          const SizedBox(height: LASizes.md),
          Text(
            subTitle,
            textAlign: TextAlign.justify,
            style: LATextTheme.lightTextTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
