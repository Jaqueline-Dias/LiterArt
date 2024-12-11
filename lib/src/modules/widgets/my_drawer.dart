import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/modules/widgets/dialog_app.dart';
import 'package:app_liter_art/src/modules/widgets/list_tile_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> _getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(user.uid).get();
      return snapshot.data() as Map<String, dynamic>?;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drawer header
          FutureBuilder<Map<String, dynamic>?>(
            future: _getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.only(top: 42, left: 24, bottom: 8),
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError || !snapshot.hasData) {
                return const Padding(
                  padding: EdgeInsets.only(top: 42, left: 24, bottom: 8),
                  child: Text('Erro ao carregar dados do usuário.'),
                );
              }

              final userData = snapshot.data!;
              final nickname = userData['nickname'] ?? 'Usuário';
              final profilePicture = userData['profilePicture'] ??
                  'https://via.placeholder.com/150'; // URL de fallback

              return Padding(
                padding: const EdgeInsets.only(top: 42, left: 24, bottom: 8),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/profile/user');
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(profilePicture),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text('@$nickname', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              );
            },
          ),
          const Divider(
            color: LAColors.greyDrawer,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 24, bottom: 8, top: 16),
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 18),
            ),
          ),
          // Itens do menu
          ListTileDrawer(
            size: const EdgeInsets.only(left: 32, bottom: 16),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            title: 'Home',
            image: 'assets/images/home-line.svg',
          ),
          ListTileDrawer(
            size: const EdgeInsets.only(left: 32, bottom: 16),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed('/profile/donationHistory');
            },
            title: 'Minhas doações',
            image: 'assets/images/heart-hand.svg',
          ),

          ListTileDrawer(
            size: const EdgeInsets.only(left: 32, bottom: 16),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed('/profile/evaluationHistory');
            },
            title: 'Minhas avaliações',
            image: 'assets/images/star-01.svg',
          ),

          ListTileDrawer(
            size: const EdgeInsets.only(left: 32, bottom: 16),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/profile/bookshelf');
            },
            title: 'Minha estante',
            image: 'assets/images/bookmark.svg',
          ),

          ListTileDrawer(
            size: const EdgeInsets.only(left: 32, bottom: 16),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed('/profile/achievementsHistory');
            },
            title: 'Minhas conquistas',
            image: 'assets/images/award-03.svg',
          ),

          const Divider(
            color: LAColors.greyDrawer,
          ),

          ListTileDrawer(
            size: const EdgeInsets.only(left: 32, bottom: 16),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/about');
            },
            title: 'Sobre nós',
            image: 'assets/images/info-octagon.svg',
          ),

          ListTileDrawer(
            size: const EdgeInsets.only(left: 32, bottom: 16),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/help');
            },
            title: 'Ajuda',
            image: 'assets/images/help-octagon.svg',
          ),
          ListTileDrawer(
            size: const EdgeInsets.only(left: 32, bottom: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DialogApp(
                    description:
                        'Tem certeza que deseja sair do aplicativo? Sua conta será desconectada.',
                    onPressed: () {
                      Navigator.of(context).pop();
                      _auth.signOut(); // Deslogar o usuário logado
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
