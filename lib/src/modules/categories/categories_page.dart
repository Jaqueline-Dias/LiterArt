import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/core/utils/theme/theme.dart';
import 'package:app_liter_art/src/modules/categories/adventure_category/adventure_category.dart';
import 'package:app_liter_art/src/modules/categories/education_category/education_category_page.dart';
import 'package:app_liter_art/src/modules/categories/fantasy_category/fantasy_category_page.dart';
import 'package:app_liter_art/src/modules/categories/fiction_category/fiction_category_page.dart';
import 'package:app_liter_art/src/modules/categories/horror_category/horror_category_page.dart';
import 'package:app_liter_art/src/modules/categories/others_category/others_category_page.dart';
import 'package:app_liter_art/src/modules/categories/romance_category/romance_category_page.dart';
import 'package:app_liter_art/src/modules/categories/self_help_category/self_help_category_page.dart';
import 'package:app_liter_art/src/modules/categories/thriller_category/thriller_category_page.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LAIconButtonAppBar(),
        title: const Text(LATexts.categories),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 0, left: LASizes.md, right: LASizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: LAContainerCategories(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelfHelpCategoryPage(),
                          ),
                        );
                      },
                      illustration: LAImages.illustrationSelfHelp,
                      titleCategory: LATexts.titleSelfHelp,
                    ),
                  ),
                  const SizedBox(width: LASizes.md),
                  Expanded(
                    child: LAContainerCategories(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdventureCategoryPage(),
                          ),
                        );
                      },
                      illustration: LAImages.illustrationAdventure,
                      titleCategory: LATexts.titleAdventure,
                    ),
                  ),
                ],
              ),
              // --
              const SizedBox(height: LASizes.md),
              Row(
                children: [
                  Expanded(
                    child: LAContainerCategories(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EducationCategoryPage(),
                          ),
                        );
                      },
                      illustration: LAImages.illustrationEducation,
                      titleCategory: LATexts.titleEducation,
                    ),
                  ),
                  const SizedBox(width: LASizes.md),
                  Expanded(
                    child: LAContainerCategories(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FantasyCategoryPage(),
                          ),
                        );
                      },
                      illustration: LAImages.illustrationFantasy,
                      titleCategory: LATexts.titleFantasy,
                    ),
                  ),
                ],
              ),
              // --
              const SizedBox(height: LASizes.md),
              Row(
                children: [
                  Expanded(
                    child: LAContainerCategories(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FictionCategoryPage(),
                          ),
                        );
                      },
                      illustration: LAImages.illustrationFiction,
                      titleCategory: LATexts.titleFiction,
                    ),
                  ),
                  const SizedBox(width: LASizes.md),
                  Expanded(
                    child: LAContainerCategories(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ThrillerCategoryPage(),
                          ),
                        );
                      },
                      illustration: LAImages.illustrationThriller,
                      titleCategory: LATexts.titleThriller,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: LASizes.md),
              // --
              Row(
                children: [
                  Expanded(
                    child: LAContainerCategories(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RomanceCategoryPage(),
                          ),
                        );
                      },
                      illustration: LAImages.illustrationRomance,
                      titleCategory: LATexts.titleRomance,
                    ),
                  ),
                  const SizedBox(width: LASizes.md),
                  Expanded(
                    child: LAContainerCategories(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HorrorCategoryPage(),
                          ),
                        );
                      },
                      illustration: LAImages.illustrationHorror,
                      titleCategory: LATexts.titleHorror,
                    ),
                  ),
                ],
              ),
              // --
              const SizedBox(height: LASizes.md),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OthersCategoryPage(),
                    ),
                  );
                },
                child: Text(
                  LATexts.titleOtherCategories,
                  style: LATextTheme.lightTextTheme.headlineSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
