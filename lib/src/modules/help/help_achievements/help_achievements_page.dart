import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class HelpAchievementPage extends StatelessWidget {
  const HelpAchievementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LAPageIndicator(
      children: [
        LAColumnImageText(
          svgImage: LAImages.illustration6,
          title: LATexts.helpTitleAchievements1,
          subTitle: LATexts.helpSubTitleAchievements1,
        ),
        LAColumnImageText(
          svgImage: LAImages.illustration3,
          title: LATexts.helpTitleAchievements2,
          subTitle: LATexts.helpSubTitleAchievements2,
        ),
        LAColumnImageText(
          svgImage: LAImages.illustration5,
          title: LATexts.helpTitleAchievements3,
          subTitle: LATexts.helpSubTitleAchievements3,
        ),
      ],
    );
  }
}
