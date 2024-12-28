import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class HelpDonationsPage extends StatelessWidget {
  const HelpDonationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LAPageIndicator(
      children: [
        LAColumnImageText(
          svgImage: LAImages.illustration1,
          title: LATexts.helpTitleIndicator1,
          subTitle: LATexts.helSubTitleDonation1,
        ),
        LAColumnImageText(
          svgImage: LAImages.illustration2,
          title: LATexts.helpTitleIndicator2,
          subTitle: LATexts.helpSubTitleDonation2,
        ),
        LAColumnImageText(
          svgImage: LAImages.illustration3,
          title: LATexts.helpTitleDonation3,
          subTitle: LATexts.helpSubTitleDonation3,
        ),
      ],
    );
  }
}
