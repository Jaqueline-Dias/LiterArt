import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/modules/splash/pages/widgets/widget_container.dart';
import 'package:flutter/material.dart';

class SplashWelcomePage extends StatelessWidget {
  const SplashWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppLiterArtTheme.violetLigth2,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/auth/login');
              },
              child: const Text('Pular'),
            ),
          ),
        ],
      ),
      body: const Column(
        children: [
          WidgetContainer(),
          Text('data'),
        ],
      ),
    );
  }
}
