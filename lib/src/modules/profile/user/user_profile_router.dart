import 'package:app_liter_art/src/modules/profile/user/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class UserProfileRouter extends FlutterGetItModulePageRouter {
  const UserProfileRouter({super.key});

  @override
  WidgetBuilder get view => (_) => const UserProfilePage();
}
