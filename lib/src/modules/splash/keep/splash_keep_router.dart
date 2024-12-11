import 'package:app_liter_art/src/modules/splash/keep/splash_keep_page.dart';
import 'package:app_liter_art/src/modules/splash/keep/splash_keep_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class SplashKeepRouter extends FlutterGetItModulePageRouter {
  const SplashKeepRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => SplashKeepViewModel()),
      ];

  @override
  WidgetBuilder get view => (_) => const SplashKeepPage();
}
