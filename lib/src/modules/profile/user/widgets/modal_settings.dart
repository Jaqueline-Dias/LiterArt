import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:app_liter_art/src/modules/widgets/list_tile_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../edit_profile/edit_profile_page.dart';

class LAModalSettings extends StatelessWidget {
  const LAModalSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return IconButton(
      onPressed: () {
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
                    height: sizeOf.height * 0.4,
                    width: sizeOf.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(65),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text(
                              'Configurações',
                              style: LAAppTheme.titleSubDescription,
                            ),
                          ),
                          const Divider(),
                          ListTileDrawer(
                            size: const EdgeInsets.only(bottom: 8),
                            image: 'assets/images/edit-04.svg',
                            title: 'Quero editar meus dados',
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditProfilePage(),
                                ),
                              );
                            },
                          ),
                          ListTileDrawer(
                            size: const EdgeInsets.only(bottom: 8),
                            image: 'assets/images/lock-01.svg',
                            title: 'Quero redefinir minha senha',
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTileDrawer(
                            size: const EdgeInsets.only(bottom: 8),
                            image: 'assets/images/eye-off.svg',
                            title: 'Quero mudar a privacidade',
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          const SizedBox(
                            height: 32,
                          ),
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
      icon: SvgPicture.asset('assets/images/settings.svg'),
    );
  }
}
