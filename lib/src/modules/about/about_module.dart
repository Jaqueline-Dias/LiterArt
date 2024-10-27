import 'package:app_liter_art/src/modules/about/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class AboutModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/about';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (context) => const AboutPage(),
      };
}
