import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/core/utils/theme/widgets_themes/text_theme.dart';
import 'package:app_liter_art/src/modules/profile/gamification/gamification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyAchievements extends StatefulWidget {
  const MyAchievements({super.key, required this.points});
  final int points;

  @override
  State<MyAchievements> createState() => _MyAchievementsState();
}

class _MyAchievementsState extends State<MyAchievements> {
  GamificationViewModel gamificationViewModel = GamificationViewModel();

  @override
  Widget build(BuildContext context) {
    final String userTitle = gamificationViewModel.getTitle(widget.points);
    final String medalAsset = gamificationViewModel.getMedalAsset(userTitle);
    return Padding(
      padding: const EdgeInsets.all(LASizes.md),
      child: Column(
        children: [
          // -- Conquista atual do usuário
          LAContainerGamification(
            widget: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      LATexts.currentAchievement,
                      style: LATextTheme.lightTextTheme.titleMedium,
                    ),
                    const SizedBox(height: LASizes.spaceMin),
                    Text(
                      userTitle,
                      style: LATextTheme.lightTextTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(width: LASizes.defaultSpace),
                SvgPicture.asset(
                  height: LASizes.imageThumbSizeMedal,
                  medalAsset,
                  placeholderBuilder: (BuildContext context) =>
                      const CircularProgressIndicator(),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: LASizes.spaceBtwItems,
          ),
          // -- Todos os títulos adquiridos
          Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: LAContainerGamification(
                      widget: LAColumnGamification(
                        svgAsset: LAImages.medalImage1,
                        titleMedal: LATexts.titleMedal1,
                        points: '50',
                        pointsIcon: LAImages.pointsIcon,
                      ),
                    ),
                  ),
                  const SizedBox(width: LASizes.spaceMin),
                  Expanded(
                    child: LAContainerGamification(
                      widget: LAColumnGamification(
                        svgAsset: widget.points >= 100
                            ? LAImages.medalImage2
                            : LAImages.medalImageDefault,
                        titleMedal: LATexts.titleMedal2,
                        points: '100',
                        pointsIcon: LAImages.pointsIcon,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: LASizes.spaceMin),
              Row(
                children: [
                  Expanded(
                    child: LAContainerGamification(
                      widget: LAColumnGamification(
                        svgAsset: widget.points >= 150
                            ? LAImages.medalImage3
                            : LAImages.medalImageDefault,
                        titleMedal: widget.points >= 150
                            ? LATexts.titleMedal3
                            : LATexts.titleBlocked,
                        points: '150',
                        pointsIcon: LAImages.pointsIcon,
                      ),
                    ),
                  ),
                  const SizedBox(width: LASizes.spaceMin),
                  Expanded(
                    child: LAContainerGamification(
                      widget: LAColumnGamification(
                        svgAsset: widget.points >= 250
                            ? LAImages.medalImage4
                            : LAImages.medalImageDefault,
                        titleMedal: widget.points >= 250
                            ? LATexts.titleMedal4
                            : LATexts.titleBlocked,
                        points: '250',
                        pointsIcon: LAImages.pointsIcon,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: LASizes.spaceMin),
              Row(
                children: [
                  Expanded(
                    child: LAContainerGamification(
                      widget: LAColumnGamification(
                        svgAsset: widget.points >= 350
                            ? LAImages.medalImage5
                            : LAImages.medalImageDefault,
                        titleMedal: widget.points >= 350
                            ? LATexts.titleMedal5
                            : LATexts.titleBlocked,
                        points: '350',
                        pointsIcon: LAImages.pointsIcon,
                      ),
                    ),
                  ),
                  const SizedBox(width: LASizes.spaceMin),
                  Expanded(
                    child: LAContainerGamification(
                      widget: LAColumnGamification(
                        svgAsset: widget.points >= 450
                            ? LAImages.medalImage6
                            : LAImages.medalImageDefault,
                        titleMedal: widget.points >= 450
                            ? LATexts.titleMedal6
                            : LATexts.titleBlocked,
                        points: '450',
                        pointsIcon: LAImages.pointsIcon,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: LASizes.spaceMin),
              Row(
                children: [
                  Expanded(
                    child: LAContainerGamification(
                      widget: LAColumnGamification(
                        svgAsset: widget.points >= 550
                            ? LAImages.medalImage7
                            : LAImages.medalImageDefault,
                        titleMedal: widget.points >= 650
                            ? LATexts.titleMedal7
                            : LATexts.titleBlocked,
                        points: '550',
                        pointsIcon: LAImages.pointsIcon,
                      ),
                    ),
                  ),
                  const SizedBox(width: LASizes.spaceMin),
                  Expanded(
                    child: LAContainerGamification(
                      widget: LAColumnGamification(
                        svgAsset: widget.points >= 650
                            ? LAImages.medalImage8
                            : LAImages.medalImageDefault,
                        titleMedal: widget.points >= 650
                            ? LATexts.titleMedal8
                            : LATexts.titleBlocked,
                        points: '650',
                        pointsIcon: LAImages.pointsIcon,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
