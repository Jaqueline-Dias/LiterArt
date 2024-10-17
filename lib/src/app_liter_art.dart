import 'package:app_liter_art/src/core/app_liter_art_config.dart';
import 'package:app_liter_art/src/modules/auth/auth_module.dart';
import 'package:app_liter_art/src/modules/home/home_module.dart';
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
        HomeModule(),
        SplashModule(),
        AuthModule(),
        //  FeedModule(),
        // HelpModule(),
        // ReportModule(),
        // AboutModule(),
        // DevelopersModule(),
        // ProfileModule(),
      ],
    );
  }
}
