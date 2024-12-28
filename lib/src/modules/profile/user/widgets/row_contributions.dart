import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/modules/profile/donation_history/donation_history_page.dart';
import 'package:app_liter_art/src/modules/profile/evaluation_history/evaluation_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LAContributions extends StatelessWidget {
  const LAContributions(
      {super.key,
      required this.numerDonations,
      required this.numberAssessment});

  final int numerDonations;
  final int numberAssessment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DonationHistoryPage(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: LAColors.accent,
                      offset: Offset(0, 4),
                      blurRadius: 5,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Colors.white),
              child: Column(
                children: [
                  const Text(
                    LATexts.profileContributionsTitle1,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9BA9C0),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SvgPicture.asset(LAImages.donationIcon),
                  const SizedBox(
                    height: 8,
                  ),
                  Text('$numerDonations'),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EvaluationHistoryPage(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: LAColors.accent,
                      offset: Offset(0, 4),
                      blurRadius: 5,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Colors.white),
              child: Column(
                children: [
                  const Text(
                    LATexts.profileContributionsTitle2,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9BA9C0),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SvgPicture.asset(LAImages.assessmentIcon),
                  const SizedBox(
                    height: 8,
                  ),
                  Text('$numberAssessment'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
