import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/core/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LAContainerHelp extends StatelessWidget {
  const LAContainerHelp(
      {super.key,
      required this.svgIcon,
      required this.title,
      required this.subTitle,
      this.onTap});

  final String svgIcon;
  final String title;
  final String subTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: LASizes.sm),
        child: Container(
          padding: const EdgeInsets.all(LASizes.md),
          decoration: BoxDecoration(
            color: LAColors.white,
            borderRadius: BorderRadius.circular(LASizes.md),
            border: Border.all(color: LAColors.accent),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(svgIcon),
                  const SizedBox(
                    width: LASizes.spaceMin,
                  ),
                  Text(
                    title,
                    style: LATextTheme.lightTextTheme.titleMedium,
                  )
                ],
              ),
              const SizedBox(height: LASizes.sm),
              Text(
                subTitle,
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
      ),
    );
  }
}
