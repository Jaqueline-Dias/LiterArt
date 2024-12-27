import 'package:app_liter_art/src/common/widgets/widget_row_gamification.dart';
import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class AllTitles extends StatelessWidget {
  const AllTitles({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
          left: LASizes.spaceBtwItems, right: LASizes.spaceBtwItems),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LARowGamification(
            titleMedal: LATexts.titleMedal1,
            number: '50',
          ),
          LARowGamification(
            titleMedal: LATexts.titleMedal2,
            number: '100',
          ),
          LARowGamification(
            titleMedal: LATexts.titleMedal3,
            number: '150',
          ),
          LARowGamification(
            titleMedal: LATexts.titleMedal4,
            number: '250',
          ),
          LARowGamification(
            titleMedal: LATexts.titleMedal5,
            number: '350',
          ),
          LARowGamification(
            titleMedal: LATexts.titleMedal6,
            number: '450',
          ),
          LARowGamification(
            titleMedal: LATexts.titleMedal7,
            number: '550',
          ),
          LARowGamification(
            titleMedal: LATexts.titleMedal8,
            number: '650',
          )
        ],
      ),
    );
  }
}
