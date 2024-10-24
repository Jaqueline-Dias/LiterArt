import 'package:app_liter_art/src/modules/feed/feed_assessments/feed_assessment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class FeedAssessmentRouter extends FlutterGetItModulePageRouter {
  const FeedAssessmentRouter({super.key});

  @override
  WidgetBuilder get view => (_) => const FeedAssessmentPage();
}
