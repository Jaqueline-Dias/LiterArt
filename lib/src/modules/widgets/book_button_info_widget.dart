import 'package:flutter/material.dart';

// Botão estilizado com um ícone e texto.
class BookButtonInfoWidget extends StatelessWidget {
  final String text;
  final Function() onPressedFn;
  final IconData icon;
  final Color btnColor;

  const BookButtonInfoWidget({
    super.key,
    required this.text,
    required this.onPressedFn,
    required this.icon,
    required this.btnColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressedFn,
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: btnColor,
                ),
              ),
            ),
            Icon(icon, color: btnColor),
          ],
        ),
      ),
    );
  }
}
