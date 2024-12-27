import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/core/utils/theme/widgets_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LAColumnGamification extends StatelessWidget {
  const LAColumnGamification(
      {super.key,
      required this.svgAsset,
      required this.titleMedal,
      required this.points,
      required this.pointsIcon});

  final String svgAsset;
  final String titleMedal;
  final String points;
  final String pointsIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          svgAsset,
        ),
        const SizedBox(height: LASizes.sm),
        Text(
          titleMedal,
          style: LATextTheme.lightTextTheme.labelLarge,
        ),
        const SizedBox(height: LASizes.sm),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(points, style: LATextTheme.lightTextTheme.bodySmall),
            const SizedBox(width: LASizes.sm),
            SvgPicture.asset(pointsIcon),
          ],
        )
      ],
    );
  }
}
