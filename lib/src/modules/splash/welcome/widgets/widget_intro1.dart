import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/modules/splash/welcome/widgets/widget_container1.dart';
import 'package:flutter/material.dart';

class WidgetIntro1 extends StatelessWidget {
  const WidgetIntro1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        WidgetContainer1(),
        SizedBox(
          height: 16,
        ),
        Center(
          child: Text(
            'Nosso propósito',
            style: LAAppTheme.titleSplash,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: EdgeInsets.only(left: 24, right: 16),
          child: Text(
            'Ajudar a incentivar o hábito de leitura e apoiar o acesso aos livros para todos. Esperamos levar a leitura ao maior número possível de pessoas e com isso também seja possível auxiliar na redução dos índices de analfabetismo existentes no Brasil.',
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
