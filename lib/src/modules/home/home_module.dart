import 'package:app_liter_art/src/modules/home/home_page.dart';
import 'package:app_liter_art/src/modules/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class HomeModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton(
          (i) => HomeViewModel(),
        ),
      ];

  @override
  String get moduleRouteName => '/home';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (context) => const HomePage(),
      };
}
