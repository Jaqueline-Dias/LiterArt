import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LAButtonHistorys extends StatelessWidget {
  const LAButtonHistorys(
      {super.key, required this.title, this.onTap, required this.icon});

  final String title;
  final String icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: LAColors.accent,
          ),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: LAColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 16,
              ),
              SvgPicture.asset(icon),
            ],
          ),
        ),
      ),
    );
  }
}
