import 'package:app_liter_art/src/modules/splash/keep/splash_keep_page.dart';
import 'package:app_liter_art/src/modules/splash/loading/splash_loading_page.dart';
import 'package:app_liter_art/src/modules/splash/welcome/splash_welcome_page.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter/material.dart';

class SplashModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/splash';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/loading': (context) => const SplashLoadingPage(),
        '/keep': (context) => const SplashKeepPage(),
        '/welcome': (context) => const SplashWelcomePage(),
      };
}
