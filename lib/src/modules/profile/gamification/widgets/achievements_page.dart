import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:app_liter_art/src/modules/profile/gamification/gamification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key, required this.points});

  final int points;

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  GamificationViewModel gamificationViewModel = GamificationViewModel();

  @override
  Widget build(BuildContext context) {
    final String userTitle = gamificationViewModel.getTitle(widget.points);
    final String medalAsset = gamificationViewModel.getMedalAsset(userTitle);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(color: LAColors.buttonPrimary)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text('Seu título atual'),
                    Text(userTitle),
                  ],
                ),
                SvgPicture.asset(
                  medalAsset,
                  placeholderBuilder: (BuildContext context) =>
                      const CircularProgressIndicator(), // Placeholder enquanto o SVG carrega
                ),
                //   Image.asset('assets/images/conquistador.png')
              ],
            ),
          )
        ],
      ),
    );
  }
}
