import 'package:app_liter_art/src/modules/auth/register/register_page.dart';
import 'package:app_liter_art/src/modules/auth/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class RegisterRouter extends FlutterGetItModulePageRouter {
  const RegisterRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => RegisterViewModel()),
      ];

  @override
  WidgetBuilder get view => (_) => const RegisterPage();
}
