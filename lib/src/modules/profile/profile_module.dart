import 'package:app_liter_art/src/modules/profile/achievements_history/achievements_history_page.dart';
import 'package:app_liter_art/src/modules/profile/bookshelf/bookshelf_page.dart';
import 'package:app_liter_art/src/modules/profile/donation_history/donation_history_page.dart';
import 'package:app_liter_art/src/modules/profile/evaluation_history/evaluation_history_page.dart';
import 'package:app_liter_art/src/modules/profile/user/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class ProfileModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/profile';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/user': (context) => const UserProfilePage(),
        '/donationHistory': (context) => const DonationHistoryPage(),
        '/evaluationHistory': (context) => const EvaluationHistoryPage(),
        '/bookshelf': (context) => const BookshelfPage(),
        '/achievementsHistory': (context) => const AchievementsHistoryPage(),
      };
}
