import 'package:app_liter_art/src/modules/feed/feed_donations/feed_donation_page.dart';
import 'package:app_liter_art/src/modules/feed/feed_donations/feed_donations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class FeedDonationsRouter extends FlutterGetItModulePageRouter {
  const FeedDonationsRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => FeedDonationsViewModel()),
      ];

  @override
  WidgetBuilder get view => (_) => const FeedDonationPage();
}
