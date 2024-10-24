import 'package:app_liter_art/src/modules/feed/feed_messages/feed_message_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class FeedMessagesRouter extends FlutterGetItModulePageRouter {
  const FeedMessagesRouter({super.key});

  @override
  WidgetBuilder get view => (_) => const FeedMessagePage();
}
