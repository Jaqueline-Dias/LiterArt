import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class LACategoryFeed extends StatelessWidget {
  const LACategoryFeed(
      {super.key, required this.title, required this.image, this.onTap});

  final String title;
  final String image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(LASizes.borderRadiusLg),
              ),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: LASizes.sm),
          Text(title),
        ],
      ),
    );
  }
}
