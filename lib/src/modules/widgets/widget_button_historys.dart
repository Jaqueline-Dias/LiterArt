import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class LAButtonHistorys extends StatelessWidget {
  const LAButtonHistorys({super.key, required this.title, this.onTap});

  final String title;
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
            color: LAColors.chatSender,
          ),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(color: LAColors.darkerGrey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 16,
              ),
              const Icon(
                Icons.add,
                color: LAColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
