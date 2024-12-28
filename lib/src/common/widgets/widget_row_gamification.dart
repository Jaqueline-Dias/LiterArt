import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/core/utils/theme/widgets_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LARowGamification extends StatelessWidget {
  const LARowGamification({
    super.key,
    required this.titleMedal,
    required this.number,
  });

  final String titleMedal;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: LASizes.sm),
      child: LAContainerGamification(
        widget: Padding(
          padding: const EdgeInsets.all(LASizes.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titleMedal,
                style: LATextTheme.lightTextTheme.titleMedium,
              ),
              Row(
                children: [
                  Text(
                    number,
                    style: LATextTheme.lightTextTheme.bodyLarge,
                  ),
                  const SizedBox(width: LASizes.sm),
                  SvgPicture.asset(LAImages.pointsIcon),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
