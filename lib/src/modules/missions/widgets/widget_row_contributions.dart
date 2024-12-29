import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class LARowHistoryContributions extends StatelessWidget {
  const LARowHistoryContributions({
    super.key,
    required this.donations,
    required this.requests,
    required this.assessments,
  });

  final int donations;
  final int requests;
  final int assessments;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('$donations ${LATexts.donations}'),
        const LADivider(
          color: LAColors.buttonPrimary,
          height: LASizes.lg,
          width: 1,
        ),
        Text('$requests ${LATexts.requests}'),
        const LADivider(
          color: LAColors.buttonPrimary,
          height: LASizes.lg,
          width: 1,
        ),
        Text('$assessments ${LATexts.assessments}'),
      ],
    );
  }
}
