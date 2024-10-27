import 'package:app_liter_art/src/modules/profile/achievements_history/achievements_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class AchievementsHistoryRouter extends FlutterGetItModulePageRouter {
  const AchievementsHistoryRouter({super.key});

  @override
  WidgetBuilder get view => (_) => const AchievementsHistoryPage();
}
