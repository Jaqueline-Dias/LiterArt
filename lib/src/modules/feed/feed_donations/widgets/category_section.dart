import 'package:app_liter_art/src/modules/widgets/text_title.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: sizeOf.width,
        height: sizeOf.height * 0.05,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextTitle(
              title: 'Explorar categorias',
            ),
            TextTitle(
              title: 'Ver tudo',
              color: false,
            ),
          ],
        ),
      ),
    );
  }
}
