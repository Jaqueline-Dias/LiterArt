import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/model/model_assessment.dart';
import 'package:app_liter_art/src/modules/home/widgets/text_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedAssessmentPage extends StatefulWidget {
  const FeedAssessmentPage({super.key});

  @override
  State<FeedAssessmentPage> createState() => _FeedAssessmentPageState();
}

class _FeedAssessmentPageState extends State<FeedAssessmentPage> {
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  int count = 0;

  //Retornar o nome do usuário que realizou o post
  Future<String> _getUserName(String userId) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userSnapshot.exists) {
      return userSnapshot['nickname'];
    } else {
      return 'Usuário desconhecido';
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
          const TextTitle(
            title: 'Últimas obras avaliadas',
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('assessments')
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
                primary: false,
                itemCount: documentos.length,
                itemBuilder: (context, index) {
                  ModelAssessment postagem =
                      ModelAssessment.fromDocument(documentos[index]);
                  // Obter total de páginas e páginas lidas dos dados do Firestore
                  int totalPaginas = int.tryParse(
                          documentos[index]['pageNumber'].toString()) ??
                      1; // Evita divisão por zero
                  int paginasLidas =
                      int.tryParse(documentos[index]['pagesRead'].toString()) ??
                          0;
                  double progresso = paginasLidas / totalPaginas;
                  // Obter a nota do Firebase (rating de 1 a 5)
                  int rating = documentos[index]['note'] ?? 0;

                  return Card(
                    margin:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 4),
                    color: Colors.white,
                    shadowColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Exibir o nome do usuário que registrou
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(postagem.profilePicture!),
                                  radius: 16,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: FutureBuilder(
                                  future: _getUserName(postagem.userUid!),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Text("Carregando...");
                                    } else if (snapshot.hasError) {
                                      return const Text(
                                          "Erro ao carregar o nome do usuário");
                                    } else {
                                      return Text(
                                        "${snapshot.data}",
                                      );
                                    }
                                  },
                                ),
                              ),
                              const Spacer(),
                              //Exibe a data de postagem
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  '27 Abr 2024',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                        '${(documentos[index]['title'])}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          '${(documentos[index]['author'])}',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Chip(
                                        label: Text(
                                          documentos[index]['category']!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppLiterArtTheme.violet,
                                          ),
                                        ),
                                        backgroundColor:
                                            AppLiterArtTheme.violetLigth2,
                                        side: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      // Barra de Progresso de Leitura
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Páginas lidas'),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: sizeOf.height * 0.02,
                                                width: sizeOf.width * 0.3,
                                                child: LinearProgressIndicator(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  value: progresso,
                                                  backgroundColor:
                                                      Colors.grey[300],
                                                  color: AppLiterArtTheme
                                                      .violetButton,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                '${(progresso * 100).toStringAsFixed(0)}%',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      AppLiterArtTheme.violet,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Divider(),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 16, bottom: 16),
                            child: Text(
                              documentos[index]['comment'],
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          // Exibir as Estrelas com Base na Nota
                          Row(
                            children: [
                              Text('${documentos[index]['note']},0'),
                              const SizedBox(
                                width: 8,
                              ),
                              Row(
                                children: List.generate(5, (starIndex) {
                                  return Icon(
                                    starIndex < rating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: AppLiterArtTheme.violetButton,
                                    size: 20,
                                  );
                                }),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
