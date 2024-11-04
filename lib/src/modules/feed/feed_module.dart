import 'package:app_liter_art/src/modules/feed/feed_assessments/feed_assessment_page.dart';
import 'package:app_liter_art/src/modules/liter_art_service/assessments/assessment_page.dart';
import 'package:app_liter_art/src/modules/liter_art_service/requests/request_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class FeedModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/feed';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/feeddonation': (context) => const FeedAssessmentPage(),
        '/assessment': (context) => const AssessmentPage(),
        //'/request': (context) => const RequestPage(),
      };
}
