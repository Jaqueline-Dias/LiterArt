import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils.dart';
import 'package:app_liter_art/src/model/model_donation.dart';
import 'package:app_liter_art/src/modules/feed/feed_donations/widgets/book_details_page.dart';
import 'package:app_liter_art/src/modules/feed/feed_donations/widgets/category_books.dart';
import 'package:app_liter_art/src/modules/feed/feed_donations/widgets/category_section.dart';
import 'package:app_liter_art/src/modules/home/widgets/text_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedDonationPage extends StatefulWidget {
  const FeedDonationPage({super.key});

  @override
  State<FeedDonationPage> createState() => _FeedDonationPageState();
}

class _FeedDonationPageState extends State<FeedDonationPage> {
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  final Utils utils = Utils();

  // Retorna o nome e a foto de perfil do usuário que realizou o post
  Future<Map<String, dynamic>> _getUserDetails(String userId) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userSnapshot.exists) {
      return {
        'nickname': userSnapshot['nickname'] ?? 'Usuário desconhecido',
        'profilePicture': userSnapshot['profilePicture'] ??
            'https://firebasestorage.googleapis.com/v0/b/literart-529e2.appspot.com/o/profile_default.png?alt=media&token=1aefd6f3-94bf-47ff-bd31-f304d543fdb1',
      };
    } else {
      return {
        'nickname': 'Usuário desconhecido',
        'profilePicture':
            'https://firebasestorage.googleapis.com/v0/b/literart-529e2.appspot.com/o/profile_default.png?alt=media&token=1aefd6f3-94bf-47ff-bd31-f304d543fdb1',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return SizedBox(
      width: sizeOf.width,
      height: sizeOf.height,
      child: Column(
        children: [
          const TextTitle(title: 'Vamos achar sua próxima leitura!'),
          const CategorySection(),
          const CategoryBooks(),
          const TextTitle(title: 'Últimos livros doados'),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('donations')
                  .orderBy('publicationDate', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Erro ao recuperar os dados",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<DocumentSnapshot> documentos = snapshot.data!.docs;

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: documentos.length,
                  itemBuilder: (context, index) {
                    ModelDonation postagem =
                        ModelDonation.fromDocument(documentos[index]);

                    return FutureBuilder<Map<String, dynamic>>(
                      future: _getUserDetails(postagem.userUid!),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (userSnapshot.hasError) {
                          return const Center(
                            child: Text(
                              "Erro ao carregar dados do usuário",
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        }

                        final userData = userSnapshot.data!;

                        return Card(
                          margin: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 4),
                          color: Colors.white,
                          shadowColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          userData['profilePicture']),
                                      radius: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(userData['nickname']),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        utils.formatDate(documentos[index]
                                            ["publicationDate"]),
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Image.network(
                                      postagem.bookCover!,
                                      fit: BoxFit.cover,
                                      height: 180,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: SizedBox(
                                        width: sizeOf.width * .5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              documentos[index]['title'],
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            Text(documentos[index]['authors']),
                                            const SizedBox(height: 8),
                                            Chip(
                                              label: Text(
                                                documentos[index]['category'],
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      AppLiterArtTheme.violet,
                                                ),
                                              ),
                                              backgroundColor:
                                                  AppLiterArtTheme.violetLigth2,
                                              side: const BorderSide(
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(height: 8),
                                            Chip(
                                              label: Text(
                                                'Pág. ${documentos[index]['pageNumber']}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      AppLiterArtTheme.violet,
                                                ),
                                              ),
                                              backgroundColor:
                                                  AppLiterArtTheme.violetLigth2,
                                              side: const BorderSide(
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BookDetailPage(
                                          title: documentos[index]['title'],
                                          authors: documentos[index]['authors'],
                                          coverImage: postagem.bookCover!,
                                          synopsis: documentos[index]
                                                  ['synopsis'] ??
                                              'Descrição não disponível',
                                          pageNumber: documentos[index]
                                              ['pageNumber'],
                                          category: documentos[index]
                                              ['category'],
                                          language: documentos[index]
                                              ['language'],
                                          publicationDate: documentos[index]
                                              ['publicationDate'],
                                          conservation: documentos[index]
                                              ['conservation'],
                                          photos: documentos[index]['photos'],
                                          userUid: documentos[index]['userUid'],
                                          nickname: userData['nickname'],
                                          profilePicture:
                                              userData['profilePicture'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: sizeOf.width * 0.52,
                                    height: sizeOf.height * 0.04,
                                    decoration: const BoxDecoration(
                                      color: AppLiterArtTheme.violetButton,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(16),
                                        topLeft: Radius.circular(16),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Ver mais detalhes',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
