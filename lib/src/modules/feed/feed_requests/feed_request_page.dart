import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils.dart';
import 'package:app_liter_art/src/model/model_request.dart';
import 'package:app_liter_art/src/modules/home/widgets/text_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FeedRequestPage extends StatefulWidget {
  const FeedRequestPage({super.key});

  @override
  State<FeedRequestPage> createState() => _FeedRequestPageState();
}

class _FeedRequestPageState extends State<FeedRequestPage> {
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
    return Column(
      children: [
        const TextTitle(
          title: 'Últimos livros solicitados',
        ),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('requests')
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
                  ModelRequest postagem =
                      ModelRequest.fromDocument(documentos[index]);

                  return FutureBuilder<Map<String, dynamic>>(
                    future: _getUserDetails(postagem.userUid!),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Exibir o nome do usuário que registrou
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        userData['profilePicture']),
                                    radius: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(userData['nickname'])),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      utils.formatDate(
                                          documentos[index]["publicationDate"]),
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    postagem.bookCover!,
                                    fit: BoxFit.cover,
                                    height: 180,
                                    width: 100,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${(documentos[index]['title'])}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          '${(documentos[index]['author'])}',
                                          style: const TextStyle(
                                              color: AppLiterArtTheme.grey),
                                        ),
                                        const SizedBox(height: 8),
                                        Chip(
                                          label: Text(
                                            documentos[index]['category']!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: AppLiterArtTheme.violet,
                                            ),
                                          ),
                                          side: const BorderSide(
                                              color: Colors.white),
                                          backgroundColor:
                                              AppLiterArtTheme.violetLigth2,
                                        ),
                                        const SizedBox(height: 8),
                                        Chip(
                                          label: Text(
                                            'Pág. ${documentos[index]['pageNumber']!.toString()}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: AppLiterArtTheme.violet,
                                            ),
                                          ),
                                          side: const BorderSide(
                                              color: Colors.white),
                                          backgroundColor:
                                              AppLiterArtTheme.violetLigth2,
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  documentos[index]['description'],
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'assets/images/message-chat-circle.svg',
                                ),
                                label: const Text('Enviar mensagem'),
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
    );
  }
}
