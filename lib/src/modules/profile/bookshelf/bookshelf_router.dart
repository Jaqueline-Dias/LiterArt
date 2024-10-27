import 'package:app_liter_art/src/modules/profile/bookshelf/bookshelf_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class BookshelfRouter extends FlutterGetItModulePageRouter {
  const BookshelfRouter({super.key});

  @override
  WidgetBuilder get view => (_) => const BookshelfPage();
}
