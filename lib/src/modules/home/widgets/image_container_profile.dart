import 'package:app_liter_art/src/modules/home/widgets/container_profile.dart';
import 'package:flutter/material.dart';

class ImageContainerProfile extends StatelessWidget {
  const ImageContainerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 15,
        top: 20,
        right: 15,
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: const [
            Center(
              child: Stack(
                children: [
                  //Imagem da foto e decoração do container
                  ContainerProfile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
