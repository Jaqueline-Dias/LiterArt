import 'package:app_liter_art/src/common/widgets/widget_container_missions.dart';
import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/core/utils/theme/theme.dart';
import 'package:app_liter_art/src/modules/missions/missions_view_model.dart';
import 'package:app_liter_art/src/modules/missions/widgets/widget_modal_missions.dart';
import 'package:app_liter_art/src/modules/missions/widgets/widget_row_contributions.dart';
import 'package:app_liter_art/src/modules/profile/user/user_view_model.dart';
import 'package:flutter/material.dart';

class MissionsPage extends StatelessWidget {
  const MissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = UserViewModel();
    MissionsViewModel viewModel = MissionsViewModel();

    return Scaffold(
      appBar: AppBar(
        leading: const LAIconButtonAppBar(),
        title: const Text(LATexts.missions),
        actions: const [LAModalMissions()],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>?>(
            future: userViewModel.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || !snapshot.hasData) {
                return const Center(child: Text(LATexts.onBoardingTitle1));
              }
              final userData = snapshot.data!;
              return FutureBuilder<Map<String, int>>(
                future: userViewModel.getUserContributions(userData['userUid']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const Text(LATexts.onBoardingTitle1);
                  }
                  final contributions = snapshot.data!;
                  final donations = contributions['donations']!;
                  final assessments = contributions['assessments']!;
                  final requests = contributions['requests']!;

                  return Padding(
                    padding: const EdgeInsets.all(LASizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          LATexts.missionsSubTitle1,
                          style: LATextTheme.lightTextTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: LASizes.sm),
                        LARowHistoryContributions(
                          donations: donations,
                          assessments: assessments,
                          requests: requests,
                        ),
                        const SizedBox(height: LASizes.md),
                        LAContainerMissions(
                          title: LATexts.missionsSubTitle2,
                          value: donations / viewModel.donationsMission1,
                        ),
                        LAContainerMissions(
                          title: LATexts.missionsSubTitle3,
                          value: requests / viewModel.requestsMission1,
                        ),
                        LAContainerMissions(
                          title: LATexts.missionsSubTitle4,
                          value: assessments / viewModel.assessmentsMission1,
                        ),
                        LAContainerMissions(
                          title: LATexts.missionsSubTitle5,
                          value: donations / viewModel.donationsMission2,
                        ),
                        LAContainerMissions(
                          title: LATexts.missionsSubTitle6,
                          value: requests / viewModel.requestsMission2,
                        ),
                        LAContainerMissions(
                          title: LATexts.missionsSubTitle7,
                          value: assessments / viewModel.assessmentsMission2,
                        ),
                        const SizedBox(height: LASizes.md),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed('/service/search'),
                          child: const Text(
                            LATexts.missionsButton,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
