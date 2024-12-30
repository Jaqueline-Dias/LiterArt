import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/core/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class LAContainerCategories extends StatelessWidget {
  const LAContainerCategories({
    super.key,
    required this.illustration,
    required this.titleCategory,
    this.onTap,
  });

  final String illustration;
  final String titleCategory;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(LASizes.borderRadiusLg),
              ),
              image: DecorationImage(
                image: AssetImage(illustration),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: LASizes.xs),
          Text(
            titleCategory,
            style: LATextTheme.lightTextTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
