import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/modules/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DonationRegistrationConfirm extends StatelessWidget {
  const DonationRegistrationConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset('assets/images/shopping-shipping.svg'),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Doação realizada com sucesso!',
                style: LAAppTheme.authorMobileDateStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                '+ 30 pontos de leitor',
                style: LAAppTheme.textInfoAppBar,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () {
                  final navigator = Navigator.of(context);
                  navigator.pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: const Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
