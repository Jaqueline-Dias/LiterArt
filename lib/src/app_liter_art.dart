import 'package:app_liter_art/src/core/app_liter_art_config.dart';
import 'package:app_liter_art/src/modules/about/about_module.dart';
import 'package:app_liter_art/src/modules/auth/auth_module.dart';
import 'package:app_liter_art/src/modules/feed/feed_module.dart';
import 'package:app_liter_art/src/modules/help/help_module.dart';
import 'package:app_liter_art/src/modules/home/home_module.dart';
import 'package:app_liter_art/src/modules/liter_art_service/liter_art_service_module.dart';
import 'package:app_liter_art/src/modules/profile/profile_module.dart';
import 'package:app_liter_art/src/modules/splash/pages/splash_loading_page.dart';
import 'package:app_liter_art/src/modules/splash/splash_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class AppLiterArt extends StatelessWidget {
  const AppLiterArt({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLiterArtConfig(
      title: 'LiterArt',
      pagesBuilders: [
        FlutterGetItPageBuilder(
          page: (_) => const SplashLoadingPage(),
          path: '/',
        ),
      ],
      modules: [
        HomeModule(), //Módulo home
        SplashModule(), //Módulo das splash
        AuthModule(), //Módulo de autenticação
        LiterArtServiceModule(), //Módulo das principais funcionalidades "Serviços" do app
        FeedModule(), //Módulo dos feeds de publicações
        ProfileModule(), // Módulo do perfil de usuário
        AboutModule(), // Módulo sobre
        HelpModule(), // Módulo de ajuda
      ],
    );
  }
}
