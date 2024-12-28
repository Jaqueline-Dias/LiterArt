import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class HelpRequestPage extends StatelessWidget {
  const HelpRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LAPageIndicator(
      children: [
        LAColumnImageText(
          svgImage: LAImages.illustration7,
          title: LATexts.helpTitleIndicator1,
          subTitle: LATexts.helpSubTitleRequest1,
        ),
        LAColumnImageText(
          svgImage: LAImages.illustration8,
          title: LATexts.helpTitleIndicator2,
          subTitle: LATexts.helpSubTitleRequest3,
        ),
        LAColumnImageText(
          svgImage: LAImages.illustration9,
          title: LATexts.helpTitleRequest3,
          subTitle: LATexts.helpSubTitleRequest3,
        ),
      ],
    );
  }
}
