import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

class WidgetLoadingPost extends StatelessWidget {
  const WidgetLoadingPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitPouringHourGlassRefined(
              color: LAColors.buttonPrimary,
            ),
            const SizedBox(
              height: 32,
            ),
            SvgPicture.asset(
                'assets/images/interface-interface-testing-01-9.svg'),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Realizando a postagem, falta pouquinho...',
              textAlign: TextAlign.center,
              style: LAAppTheme.textInfoSearch,
            ),
          ],
        ),
      ),
    );
  }
}
