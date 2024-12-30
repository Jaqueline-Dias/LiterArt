import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/core/utils/theme/widgets_themes/text_theme.dart';
import 'package:app_liter_art/src/modules/categories/categories_page.dart';
import 'package:flutter/material.dart';

class LACategoryHeader extends StatelessWidget {
  const LACategoryHeader({
    super.key,
    required this.value,
    required this.titleCategory,
  });

  final int value;
  final String titleCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(LASizes.md),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CategoriesPage(),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LATexts.categories,
                  style: LATextTheme.lightTextTheme.titleMedium,
                ),
                Text(
                  LATexts.seeAll,
                  style: LATextTheme.lightTextTheme.titleLarge,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                titleCategory,
                style: LATextTheme.lightTextTheme.headlineSmall,
              ),
              const SizedBox(width: LASizes.sm),
              LADivider(
                color: LAColors.dark.withOpacity(0.3),
                width: 2,
                height: LASizes.lg,
              ),
              const SizedBox(width: LASizes.sm),
              Text(
                '$value',
                style: LATextTheme.lightTextTheme.headlineSmall
                        ?.copyWith(color: LAColors.dark.withOpacity(0.3)) ??
                    TextStyle(color: LAColors.dark.withOpacity(0.3)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
