import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LABottonDeleteStatus extends StatelessWidget {
  const LABottonDeleteStatus(
      {super.key,
      required this.imageIcon,
      this.onTap,
      required this.titleIcon});

  final String imageIcon;
  final String titleIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(imageIcon),
          const SizedBox(
            height: 8,
          ),
          Text(titleIcon),
        ],
      ),
    );
  }
}
