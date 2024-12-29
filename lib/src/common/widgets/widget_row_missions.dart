import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LARowMissions extends StatelessWidget {
  const LARowMissions(
      {super.key,
      required this.title,
      required this.value,
      required this.icon});

  final String title;
  final String value;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(LASizes.md),
      decoration: BoxDecoration(
        color: LAColors.accent,
        borderRadius: BorderRadius.circular(LASizes.sm),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          const SizedBox(width: LASizes.xs),
          Text(value),
          const SizedBox(width: LASizes.xs),
          SvgPicture.asset(icon),
        ],
      ),
    );
  }
}
