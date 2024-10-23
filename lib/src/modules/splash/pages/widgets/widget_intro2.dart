import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/modules/splash/pages/widgets/widget_container2.dart';
import 'package:flutter/material.dart';

class WidgetIntro2 extends StatelessWidget {
  const WidgetIntro2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        WidgetContainer2(),
        SizedBox(
          height: 16,
        ),
        Center(
          child: Text(
            'Além disso...',
            style: AppLiterArtTheme.titleSplash,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: EdgeInsets.only(left: 24, right: 16),
          child: Text(
            'Aqui você encontra desafios, acumula pontos de leitor, alcança conquistas e organiza sua estante de leitura!',
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
