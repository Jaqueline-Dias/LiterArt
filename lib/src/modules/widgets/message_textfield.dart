import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:flutter/material.dart';

class CustomChatTextField extends StatelessWidget {
  final TextEditingController controller;

  const CustomChatTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: LAColors.lightContainer),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: LAColors.lightContainer)),
          fillColor: LAColors.accent,
          filled: true,
        ),
      ),
    );
  }
}
