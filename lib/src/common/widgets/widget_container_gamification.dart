import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class LAContainerGamification extends StatelessWidget {
  const LAContainerGamification({super.key, required this.widget, this.width});

  final Widget widget;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LASizes.borderRadiusLg),
        color: LAColors.white,
        border: Border.all(
          color: LAColors.accent,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(LASizes.md),
        child: widget,
      ),
    );
  }
}
