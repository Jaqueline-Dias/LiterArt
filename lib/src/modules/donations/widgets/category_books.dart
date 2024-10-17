import 'package:flutter/material.dart';

class CategoryBooks extends StatefulWidget {
  const CategoryBooks({super.key});

  @override
  State<CategoryBooks> createState() => _CategoryBooksState();
}

class _CategoryBooksState extends State<CategoryBooks> {
  List<Map<String, String>> categories = [
    {
      "image": "assets/images/fantasy_category.jpg",
      "label": "Fantasia",
    },
    {
      "image": "assets/images/fiction_category.jpg",
      "label": "Ficção",
    },
    {
      "image": "assets/images/romance_category.jpg",
      "label": "Romance",
    },
    {
      "image": "assets/images/horror_category.jpg",
      "label": "Terror",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 105,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16),
                      ),
                      image: DecorationImage(
                        image: AssetImage(categories[index]['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(categories[index]['label']!),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
