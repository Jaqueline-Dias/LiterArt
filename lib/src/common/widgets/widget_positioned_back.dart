import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class LAPositionedBack extends StatelessWidget {
  const LAPositionedBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      top: 10,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: LAColors.accent.withOpacity(0.5),
            borderRadius: BorderRadius.circular(LASizes.md),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: LAColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
