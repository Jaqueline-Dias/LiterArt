import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/modules/profile/gamification/gamification_page.dart';
import 'package:app_liter_art/src/modules/widgets/dialog_app.dart';
import 'package:app_liter_art/src/modules/widgets/list_tile_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
              final userUid = userData['userUid'] ?? '';
              final profilePicture = userData['profilePicture'] ??
                  'https://via.placeholder.com/150';

              return Padding(
                padding: const EdgeInsets.only(top: 42, left: 0, bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/profile/user');
                            },
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(profilePicture),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text('@$nickname',
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
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
                      size: const EdgeInsets.only(
                          left: LASizes.sm, bottom: LASizes.sm),
                      onTap: () {
                        Navigator.of(context).pushNamed('/home');
                      },
                      title: 'Home',
                      image: 'assets/images/home-line.svg',
                    ),
                    ListTileDrawer(
                      size: const EdgeInsets.only(
                          left: LASizes.sm, bottom: LASizes.sm),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/profile/donationHistory');
                      },
                      title: 'Minhas doações',
                      image: LAImages.iconDonation,
                    ),

                    ListTileDrawer(
                      size: const EdgeInsets.only(
                          left: LASizes.sm, bottom: LASizes.sm),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/profile/evaluationHistory');
                      },
                      title: 'Minhas avaliações',
                      image: LAImages.iconAssessment,
                    ),

                    ListTileDrawer(
                      size: const EdgeInsets.only(
                          left: LASizes.sm, bottom: LASizes.sm),
                      onTap: () {
                        Navigator.of(context).pushNamed('/profile/bookshelf');
                      },
                      title: 'Minha estante',
                      image: 'assets/images/bookmark.svg',
                    ),

                    ListTileDrawer(
                      size: const EdgeInsets.only(
                          left: LASizes.sm, bottom: LASizes.sm),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GamificationPage(
                              userUid: userUid,
                            ),
                          ),
                        );
                      },
                      title: 'Minhas conquistas',
                      image: LAImages.iconAchievement,
                    ),

                    const Divider(
                      color: LAColors.greyDrawer,
                    ),

                    ListTileDrawer(
                      size: const EdgeInsets.only(
                          left: LASizes.sm, bottom: LASizes.sm),
                      onTap: () {
                        Navigator.of(context).pushNamed('/about');
                      },
                      title: 'Sobre nós',
                      image: 'assets/images/info-octagon.svg',
                    ),

                    ListTileDrawer(
                      size: const EdgeInsets.only(
                          left: LASizes.sm, bottom: LASizes.sm),
                      onTap: () {
                        Navigator.of(context).pushNamed('/help');
                      },
                      title: 'Ajuda',
                      image: LAImages.iconHelp,
                    ),
                    ListTileDrawer(
                      size: const EdgeInsets.only(
                          left: LASizes.sm, bottom: LASizes.sm),
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
            },
          )
        ],
      ),
    );
  }
}
