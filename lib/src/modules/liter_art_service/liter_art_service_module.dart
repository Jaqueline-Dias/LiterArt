import 'package:app_liter_art/src/modules/liter_art_service/assessments/assessment_page.dart';
import 'package:app_liter_art/src/modules/liter_art_service/donations/donation_page.dart';
import 'package:app_liter_art/src/modules/liter_art_service/requests/request_page.dart';
import 'package:app_liter_art/src/modules/liter_art_service/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class LiterArtServiceModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/service';

  @override
  Map<String, WidgetBuilder> get pages => {
        // '/donation': (context) => const DonationPage(),
        //'/assessment': (context) => const AssessmentPage(),
        // '/request': (context) => const RequestPage(),
        '/search': (context) => const SearchPage(),
      };
}
