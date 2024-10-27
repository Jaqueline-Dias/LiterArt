import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/modules/home/widgets/container_profile.dart';
import 'package:app_liter_art/src/modules/home/widgets/dialog_app.dart';
import 'package:app_liter_art/src/modules/home/widgets/list_tile_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  var auth = FirebaseAuth.instance;
  // User? _user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Drawer header
          Padding(
            padding: const EdgeInsets.only(top: 42, left: 24, bottom: 8),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/profile/user');
                  },
                  child: const ContainerProfile(),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text('@nickname'),
              ],
            ),
          ),
          const Divider(
            color: AppLiterArtTheme.greyDrawer,
          ),

          const Padding(
            padding: EdgeInsets.only(left: 24, bottom: 8, top: 16),
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 18),
            ),
          ),

          ListTileDrawer(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            title: 'Home',
            image: 'assets/images/home-line.svg',
          ),

          ListTileDrawer(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed('/profile/donationHistory');
            },
            title: 'Minhas doações',
            image: 'assets/images/heart-hand.svg',
          ),

          ListTileDrawer(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed('/profile/evaluationHistory');
            },
            title: 'Minhas avaliações',
            image: 'assets/images/star-01.svg',
          ),

          ListTileDrawer(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/profile/bookshelf');
            },
            title: 'Minha estante',
            image: 'assets/images/bookmark.svg',
          ),

          ListTileDrawer(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed('/profile/achievementsHistory');
            },
            title: 'Minhas conquistas',
            image: 'assets/images/award-03.svg',
          ),

          const Divider(
            color: AppLiterArtTheme.greyDrawer,
          ),

          ListTileDrawer(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/about');
            },
            title: 'Sobre nós',
            image: 'assets/images/info-octagon.svg',
          ),

          ListTileDrawer(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/help');
            },
            title: 'Ajuda',
            image: 'assets/images/help-octagon.svg',
          ),

          ListTileDrawer(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DialogApp(
                    description:
                        'Tem certeza que deseja sair do aplicativo? Sua conta será desconectada.',
                    onPressed: () {
                      Navigator.of(context).pop();
                      auth.signOut(); //Deslogar o usuário logado
                      SystemNavigator.pop(); // Sair do aplicativo
                    },
                    title: 'Confirmar saída',
                    titleButton: 'Sair',
                  );
                },
              );
            },
            title: 'Logout',
            image: 'assets/images/log-out-04.svg',
          ),
        ],
      ),
    );
  }
}
