import 'package:app_liter_art/src/modules/liter_art_service/requests/request_page.dart';
import 'package:app_liter_art/src/modules/liter_art_service/requests/request_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class RequestRouter extends FlutterGetItModulePageRouter {
  const RequestRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => RequestViewModel()),
      ];

  @override
  WidgetBuilder get view => (_) => const RequestPage();
}
