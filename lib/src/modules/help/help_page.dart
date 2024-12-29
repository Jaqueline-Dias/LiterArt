import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/modules/help/help_achievements/help_achievements_page.dart';
import 'package:app_liter_art/src/modules/help/help_assessment/help_assessment_page.dart';
import 'package:app_liter_art/src/modules/help/help_donations/help_donations_page.dart';
import 'package:app_liter_art/src/modules/help/help_request/help_request_page.dart';
import 'package:app_liter_art/src/modules/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        leading: const LAIconButtonAppBar(),
        title: const Text(LATexts.help),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LASizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LAContainerHelp(
                svgIcon: LAImages.iconDonation,
                title: LATexts.helpTitle1,
                subTitle: LATexts.helpSubTitle1,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpDonationsPage(),
                    ),
                  );
                },
              ),
              LAContainerHelp(
                svgIcon: LAImages.iconRequest,
                title: LATexts.helpTitle2,
                subTitle: LATexts.helpSubTitle2,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpRequestPage(),
                    ),
                  );
                },
              ),
              LAContainerHelp(
                svgIcon: LAImages.iconAssessment,
                title: LATexts.helpTitle3,
                subTitle: LATexts.helpSubTitle3,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpAssessmentPage(),
                    ),
                  );
                },
              ),
              LAContainerHelp(
                svgIcon: LAImages.iconAchievement,
                title: LATexts.helpTitle4,
                subTitle: LATexts.helpSubTitle4,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpAchievementPage(),
                    ),
                  );
                },
              ),
              const LAContainerHelp(
                svgIcon: LAImages.iconHelp,
                title: LATexts.helpTitle5,
                subTitle: LATexts.helpSubTitle5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
