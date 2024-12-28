import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFieldConfig extends StatefulWidget {
  final IconData? icon;
  final String label;
  final bool isSecret;
  final String? initialValue;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const CustomTextFieldConfig({
    super.key,
    this.icon,
    required this.label,
    this.isSecret = false,
    this.controller,
    this.initialValue,
    this.readOnly = false,
    this.keyboardType,
    this.validator,
  });

  @override
  State<CustomTextFieldConfig> createState() => _CustomTextFieldConfigState();
}

class _CustomTextFieldConfigState extends State<CustomTextFieldConfig> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: TextFormField(
        obscureText: isObscure,
        initialValue: widget.initialValue,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.icon,
            color: LAColors.buttonPrimary,
          ),
          suffixIcon: widget.isSecret
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon:
                      Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                )
              : null,
          labelText: widget.label,
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
        controller: widget.controller,
        readOnly: widget.readOnly,
      ),
    );
  }
}
