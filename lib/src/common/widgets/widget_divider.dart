import 'package:flutter/material.dart';

class LADivider extends StatelessWidget {
  const LADivider({
    super.key,
    required this.color,
    required this.width,
    required this.height,
  });

  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
    );
  }
}
