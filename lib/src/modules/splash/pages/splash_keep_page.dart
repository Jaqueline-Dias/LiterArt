import 'package:app_liter_art/src/modules/splash/pages/widgets/widget_background.dart';
import 'package:app_liter_art/src/modules/splash/pages/widgets/widget_text_book.dart';
import 'package:flutter/material.dart';

class SplashKeepPage extends StatefulWidget {
  const SplashKeepPage({super.key});

  @override
  State<SplashKeepPage> createState() => _SplashKeepPageState();
}

class _SplashKeepPageState extends State<SplashKeepPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Imagem de fundo
          const WidgetBackground(
            image: AssetImage('assets/images/background01.jpg'),
          ),
          // Citação e botão "Continuar" na outra metade
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const WidgetTextBook(
                    text:
                        '“Tu te tornas eternamente responsável por aquilo que cativas.”',
                    book: 'O Pequeno Principe',
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/splash/welcome');
                    },
                    child: const Text(
                      'Continuar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
