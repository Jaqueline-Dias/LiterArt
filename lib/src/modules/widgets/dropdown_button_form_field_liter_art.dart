import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:flutter/material.dart';

class DropdownButtonFormFieldLiterArt extends StatelessWidget {
  const DropdownButtonFormFieldLiterArt({
    super.key,
    required this.title,
    this.value,
    this.valueDrop,
    required this.titleDrop,
    this.onChanged,
    required this.mainCategories,
    required this.titleButton,
    this.validator,
  });

  final String title;
  final String titleButton;
  final String? value;
  final String? valueDrop;
  final String titleDrop;
  final void Function(String?)? onChanged;
  final List<String> mainCategories;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              titleButton,
              style: const TextStyle(
                color: LAColors.violetDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          DropdownButtonFormField<String>(
            hint: Text(
              title,
              style: const TextStyle(
                  fontSize: 14,
                  color: LAColors.buttonPrimary,
                  fontWeight: FontWeight.bold),
            ),
            decoration: InputDecoration(
              filled: true, // Necessário para definir a cor de fundo
              fillColor: LAColors.accent, // Cor do interior
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(16), // Para bordas arredondadas
                borderSide: const BorderSide(
                  color: LAColors.accent, // Cor do contorno
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: LAColors.accent, // Cor do contorno quando ativo
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: LAColors.accent, // Cor do contorno ao focar
                ),
              ),
            ),
            dropdownColor: LAColors.accent, // Cor do menu suspenso
            value: value,
            isExpanded: true,
            items: [
              ...mainCategories.map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(
                    category,
                    style: const TextStyle(
                      color: LAColors.textPrimary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              DropdownMenuItem(
                value: valueDrop,
                child: Text(
                  titleDrop,
                  style: const TextStyle(
                    color: LAColors.textPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
            onChanged: onChanged,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
