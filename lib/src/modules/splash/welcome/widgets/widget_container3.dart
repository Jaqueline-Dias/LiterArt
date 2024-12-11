import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:flutter/material.dart';

class WidgetContainer3 extends StatelessWidget {
  const WidgetContainer3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height * 0.5, // Metade da altura da tela
      width: double.infinity, // Ocupa toda a largura
      decoration: const BoxDecoration(
        color: LAColors.accent,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(65),
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/splash2.png'),
          fit: BoxFit.none,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.only(left: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Junte-se',
              style: TextStyle(
                fontSize: 18,
                color: LAColors.textPrimary,
              ),
            ),
            Text(
              'a nós.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: LAColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
