import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/core/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LAContainerMissions extends StatelessWidget {
  const LAContainerMissions({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    final double result = value * 100;
    final sizeOf = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: LASizes.md),
      child: Container(
        padding: const EdgeInsets.all(LASizes.md),
        decoration: BoxDecoration(
          color: LAColors.accent,
          borderRadius: BorderRadius.circular(LASizes.md),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: LATextTheme.lightTextTheme.titleMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                result >= 100.00
                    ? const Text(
                        '100%',
                      )
                    : Text(
                        '${(value * 100).toStringAsFixed(0)}%',
                      ),
                const SizedBox(width: LASizes.xs),
                SizedBox(
                  height: sizeOf.height * 0.02,
                  width: sizeOf.width * 0.5,
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(8),
                    value: value,
                    backgroundColor: Colors.grey[300],
                    color: LAColors.buttonPrimary,
                  ),
                ),
                const SizedBox(width: LASizes.xs),
                const Text(LATexts.pointsMissions),
                const SizedBox(width: LASizes.xs),
                SvgPicture.asset(LAImages.pointsIcon),
              ],
            )
          ],
        ),
      ),
    );
  }
}
