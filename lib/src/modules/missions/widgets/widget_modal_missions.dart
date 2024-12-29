import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/core/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LAModalMissions extends StatelessWidget {
  const LAModalMissions({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.only(right: LASizes.md),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(65),
              ),
            ),
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: sizeOf.height * 0.5,
                      width: sizeOf.width,
                      decoration: const BoxDecoration(
                        color: LAColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(65),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(LASizes.md),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: LASizes.xl),
                              child: Text(
                                LATexts.titleModalMissions,
                                style: LATextTheme.lightTextTheme.titleMedium,
                              ),
                            ),
                            const Divider(),
                            Text(
                              LATexts.subTitleModalMissions,
                              style: LATextTheme.lightTextTheme.titleSmall,
                            ),
                            const SizedBox(height: LASizes.md),
                            const Column(
                              children: [
                                LARowMissions(
                                  title: LATexts.subTitleModal1,
                                  value: LATexts.subSubTitleModal1,
                                  icon: LAImages.pointsIcon,
                                ),
                                SizedBox(height: LASizes.md),
                                LARowMissions(
                                  title: LATexts.subTitleModal2,
                                  value: LATexts.subSubTitleModal2,
                                  icon: LAImages.pointsIcon,
                                ),
                                SizedBox(height: LASizes.md),
                                LARowMissions(
                                  title: LATexts.subTitleModal3,
                                  value: LATexts.subSubTitleModal3,
                                  icon: LAImages.pointsIcon,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: LAColors.buttonPrimary,
                          size: 32,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Fecha o modal
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: SvgPicture.asset(
          LAImages.pointsIcon,
        ),
      ),
    );
  }
}
