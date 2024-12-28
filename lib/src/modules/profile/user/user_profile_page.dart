import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/modules/profile/gamification/gamification_page.dart';
import 'package:app_liter_art/src/modules/profile/gamification/gamification_view_model.dart';
import 'package:app_liter_art/src/modules/profile/user/user_view_model.dart';
import 'package:app_liter_art/src/modules/profile/user/widgets/row_contributions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'widgets/modal_settings.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    GamificationViewModel gamificationViewModel = GamificationViewModel();
    UserViewModel viewModel = UserViewModel();

    Future<Map<String, dynamic>?> getUserData() async {
      User? user = auth.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot =
            await firestore.collection('users').doc(user.uid).get();
        return snapshot.data() as Map<String, dynamic>?;
      }
      return null;
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed('/home'),
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: LAColors.buttonPrimary,
              size: 32,
            ),
          ),
          title: const Text('Perfil'),
          actions: const [LAModalSettings()],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<Map<String, dynamic>?>(
                future: getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 42, left: 24, bottom: 8),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 42, left: 24, bottom: 8),
                      child: Text('Erro ao carregar dados do usuário.'),
                    );
                  }
                  final userData = snapshot.data!;
                  final nickname = userData['nickname'] ?? 'Usuário';
                  final points = userData['points'] ?? '50';
                  final profilePicture = userData['profilePicture'] ??
                      'https://via.placeholder.com/150';
                  final biography = userData['biography'] ?? '';
                  final String userTitle =
                      gamificationViewModel.getTitle(points);
                  final String medalAsset =
                      gamificationViewModel.getMedalAsset(userTitle);
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(profilePicture),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text('@$nickname',
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(
                            height: 8,
                          ),
                          SvgPicture.asset('assets/images/alquimista.svg'),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(biography),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 16, top: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: LAColors.accent,
                                  offset: Offset(0, 4),
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  'Nível',
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                SvgPicture.asset(
                                  'assets/images/progress_profile.svg',
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SvgPicture.asset(
                                      medalAsset,
                                      height: 56,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Pontos de leitor',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF9BA9C0),
                                          ),
                                        ),
                                        Text('$points pontos'),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text(
                                          'Título de leitor',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF9BA9C0),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    GamificationPage(
                                                  userUid: userData['userUid'],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Text(userTitle),
                                              const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: Color(0xFFEDDBFF),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),

                          // -- Contribuições do usuário
                          const Text(
                            LATexts.profileContributions,
                            style: TextStyle(
                                fontSize: 16, color: LAColors.textPrimary),
                          ),
                          const SizedBox(height: 16),
                          FutureBuilder<Map<String, int>>(
                            future: viewModel
                                .getUserContributions(userData['userUid']),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError ||
                                  !snapshot.hasData) {
                                return const Text(LATexts.onBoardingTitle1);
                              }
                              final contributions = snapshot.data!;
                              return LAContributions(
                                numerDonations: contributions['donations']!,
                                numberAssessment: contributions['assessments']!,
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Estante de livros',
                            style: TextStyle(
                                fontSize: 16, color: LAColors.textPrimary),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 4, right: 4, top: 16, bottom: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: const [
                                        BoxShadow(
                                          color:
                                              LAColors.accent, // Cor da sombra
                                          offset: Offset(
                                              0, 4), // Deslocamento da sombra
                                          blurRadius:
                                              5, // O quão borrada a sombra vai ser
                                          spreadRadius:
                                              0, // O quanto a sombra vai se espalhar
                                        ),
                                      ],
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images/bookmark-minus.svg'),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text('Lendo',
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 4, right: 4, top: 16, bottom: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: const [
                                        BoxShadow(
                                          color:
                                              LAColors.accent, // Cor da sombra
                                          offset: Offset(
                                              0, 4), // Deslocamento da sombra
                                          blurRadius:
                                              5, // O quão borrada a sombra vai ser
                                          spreadRadius:
                                              0, // O quanto a sombra vai se espalhar
                                        ),
                                      ],
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images/bookmark.svg'),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text(
                                        'Quer ler',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 4, right: 4, top: 16, bottom: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: const [
                                        BoxShadow(
                                          color:
                                              LAColors.accent, // Cor da sombra
                                          offset: Offset(
                                              0, 4), // Deslocamento da sombra
                                          blurRadius:
                                              5, // O quão borrada a sombra vai ser
                                          spreadRadius:
                                              0, // O quanto a sombra vai se espalhar
                                        ),
                                      ],
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images/bookmark-check.svg'),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text(
                                        'Lido',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 4, right: 4, top: 16, bottom: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: const [
                                        BoxShadow(
                                          color:
                                              LAColors.accent, // Cor da sombra
                                          offset: Offset(
                                              0, 4), // Deslocamento da sombra
                                          blurRadius:
                                              5, // O quão borrada a sombra vai ser
                                          spreadRadius:
                                              0, // O quanto a sombra vai se espalhar
                                        ),
                                      ],
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images/bookmark-add.svg'),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text(
                                        'Solicitado',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            'Perfil público',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9BA9C0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
