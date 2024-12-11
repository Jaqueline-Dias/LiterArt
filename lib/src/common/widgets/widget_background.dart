import 'package:flutter/material.dart';

class LAWidgetBackground extends StatelessWidget {
  const LAWidgetBackground({
    super.key,
    required this.image,
  });

  final AssetImage image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(65),
        ),
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
