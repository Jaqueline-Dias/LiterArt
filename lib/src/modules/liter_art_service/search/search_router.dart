import 'package:app_liter_art/src/modules/liter_art_service/search/search_page.dart';
import 'package:app_liter_art/src/modules/liter_art_service/search/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class SearchRouter extends FlutterGetItModulePageRouter {
  const SearchRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => SearchViewModel()),
      ];

  @override
  WidgetBuilder get view => (_) => const SearchPage();
}
