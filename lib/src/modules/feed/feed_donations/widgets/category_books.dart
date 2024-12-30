import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/modules/categories/fantasy_category/fantasy_category_page.dart';
import 'package:app_liter_art/src/modules/categories/fiction_category/fiction_category_page.dart';
import 'package:app_liter_art/src/modules/categories/horror_category/horror_category_page.dart';
import 'package:app_liter_art/src/modules/categories/romance_category/romance_category_page.dart';
import 'package:flutter/material.dart';

class CategoryBooks extends StatefulWidget {
  const CategoryBooks({super.key});

  @override
  State<CategoryBooks> createState() => _CategoryBooksState();
}

class _CategoryBooksState extends State<CategoryBooks> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 105,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LACategoryFeed(
              image: LAImages.illustrationFantasy,
              title: LATexts.titleFantasy,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FantasyCategoryPage(),
                  ),
                );
              },
            ),
            LACategoryFeed(
              image: LAImages.illustrationFiction,
              title: LATexts.titleFiction,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FictionCategoryPage(),
                  ),
                );
              },
            ),
            LACategoryFeed(
              image: LAImages.illustrationRomance,
              title: LATexts.titleRomance,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RomanceCategoryPage(),
                  ),
                );
              },
            ),
            LACategoryFeed(
              image: LAImages.illustrationHorror,
              title: LATexts.titleHorror,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HorrorCategoryPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
