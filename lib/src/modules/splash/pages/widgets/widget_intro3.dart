import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/modules/splash/pages/widgets/widget_container3.dart';
import 'package:flutter/material.dart';

class WidgetIntro3 extends StatelessWidget {
  const WidgetIntro3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        WidgetContainer3(),
        SizedBox(
          height: 16,
        ),
        Center(
          child: Text(
            'Faça a diferença!',
            style: AppLiterArtTheme.titleSplash,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: EdgeInsets.only(left: 24, right: 16),
          child: Text(
            'Contribua para a democratização do acesso à leitura.',
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
