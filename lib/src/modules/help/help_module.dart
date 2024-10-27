import 'package:app_liter_art/src/modules/help/help_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class HelpModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/help';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (context) => const HelpPage(),
      };
}
