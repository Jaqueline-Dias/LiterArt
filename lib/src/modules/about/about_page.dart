import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/core/utils/theme/theme.dart';
import 'package:app_liter_art/src/modules/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        leading: const LAIconButtonAppBar(),
        title: const Text(LATexts.about),
      ),
      body: Padding(
        padding: const EdgeInsets.all(LASizes.lg),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                LATexts.aboutLiterArt,
                textAlign: TextAlign.justify,
                style: LATextTheme.lightTextTheme.titleMedium,
              ),
              const SizedBox(
                height: LASizes.lg,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    LATexts.fraseAbout,
                    textAlign: TextAlign.end,
                    style: LATextTheme.lightTextTheme.titleLarge,
                  ),
                  const SizedBox(height: LASizes.sm),
                  const Text(LATexts.authorFraseAbout),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
