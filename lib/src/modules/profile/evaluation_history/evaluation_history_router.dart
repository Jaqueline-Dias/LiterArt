import 'package:app_liter_art/src/modules/profile/evaluation_history/evaluation_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class EvaluationHistoryRouter extends FlutterGetItModulePageRouter {
  const EvaluationHistoryRouter({super.key});

  @override
  WidgetBuilder get view => (_) => const EvaluationHistoryPage();
}
