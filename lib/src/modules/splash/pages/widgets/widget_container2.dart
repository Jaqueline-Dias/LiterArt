import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:flutter/material.dart';

class WidgetContainer2 extends StatelessWidget {
  const WidgetContainer2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height * 0.5, // Metade da altura da tela
      width: MediaQuery.of(context).size.width, // Ocupa toda a largura
      decoration: const BoxDecoration(
        color: AppLiterArtTheme.violetLigth2,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(65),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Esse aplicativo é',
              style: TextStyle(
                fontSize: 18,
                color: AppLiterArtTheme.grey,
              ),
            ),
            const Text(
              'ideal para:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppLiterArtTheme.grey,
              ),
            ),
            const SizedBox(
              height: 78,
            ),
            Row(
              children: [
                Image.asset('assets/images/doar.png'),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      style: TextStyle(fontSize: 14),
                      'Doar aquele livro físico que não usa\nmais, possibilitando que outra pessoa\nfaça bom uso dele.'),
                )
              ],
            ),
            Row(
              children: [
                Image.asset('assets/images/pedir.png'),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      style: TextStyle(fontSize: 14),
                      'Pedir a doação de um livro que tanto\ndeseja ler. Você pode encontrar outras\npessoas dispostas a lhe ajudar.'),
                )
              ],
            ),
            Row(
              children: [
                Image.asset('assets/images/avaliar.png'),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      style: TextStyle(fontSize: 14),
                      'Avaliar suas obras literárias preferidas\nou nem tanto. Então compartilhe suas \nexperiências de leitura!'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
