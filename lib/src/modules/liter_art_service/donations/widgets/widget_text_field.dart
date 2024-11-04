import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:flutter/material.dart';

class WidgetTextField extends StatelessWidget {
  const WidgetTextField({
    super.key,
    this.icon,
    required this.label,
    this.validator,
    this.controller,
    this.keyboardType,
    this.maxLines,
  });

  final IconData? icon;
  final String label;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          fillColor: AppLiterArtTheme.violetLigth2,
          labelText: label,
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(18),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.red), // Cor da borda em caso de erro
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        maxLines: maxLines,
        validator: validator, // Adiciona o validador para funcionar com o Form
      ),
    );
  }
}
