import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class HelpAssessmentPage extends StatelessWidget {
  const HelpAssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LAPageIndicator(
      children: [
        LAColumnImageText(
          svgImage: LAImages.illustration4,
          title: LATexts.helpTitleIndicator1,
          subTitle: LATexts.helpSubTitleAssessment1,
        ),
        LAColumnImageText(
          svgImage: LAImages.illustration6,
          title: LATexts.helpTitleIndicator2,
          subTitle: LATexts.helpSubTitleAssessment2,
        ),
        LAColumnImageText(
          svgImage: LAImages.illustration5,
          title: LATexts.helpTitleAssessment3,
          subTitle: LATexts.helpSubTitleAssessment3,
        ),
      ],
    );
  }
}
