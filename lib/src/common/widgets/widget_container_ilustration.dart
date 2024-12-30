import 'package:flutter/material.dart';

class LAContainerIllustration extends StatelessWidget {
  const LAContainerIllustration({super.key, required this.illustration});

  final String illustration;

  @override
  Widget build(BuildContext context) {
    final double sizeOf = MediaQuery.of(context).size.width;
    return Container(
      width: sizeOf,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(65),
        ),
        image: DecorationImage(
          image: AssetImage(illustration),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
