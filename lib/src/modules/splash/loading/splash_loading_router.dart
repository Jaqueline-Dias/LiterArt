import 'package:app_liter_art/src/modules/splash/loading/splash_loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class SplashLoadingRouter extends FlutterGetItModulePageRouter {
  const SplashLoadingRouter({super.key});

  @override
  WidgetBuilder get view => (_) => const SplashLoadingPage();
}
