import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/model/model_donation.dart';
import 'package:app_liter_art/src/modules/donations/book_details.dart';
import 'package:app_liter_art/src/modules/donations/widgets/category_books.dart';
import 'package:app_liter_art/src/modules/donations/widgets/category_section.dart';
import 'package:app_liter_art/src/modules/home/widgets/text_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonationFeedPage extends StatefulWidget {
  const DonationFeedPage({super.key});

  @override
  State<DonationFeedPage> createState() => _DonationFeedPageState();
}

class _DonationFeedPageState extends State<DonationFeedPage> {
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  int count = 0;

//Retornar o nome do usuário que realizou o post
  Future<String> _getUserName(String userId) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userSnapshot.exists) {
      // O usuário foi encontrado, retorna o nome
      return userSnapshot['nickname'];
    } else {
      // O usuário não foi encontrado, retorna uma mensagem padrão ou tratamento de erro
      return 'Usuário desconhecido';
    }
  }

  List<Widget> _carrossel(List<dynamic> fotos) {
    List<Widget> imagens = List.empty(growable: true);
    for (String imagem in fotos) {
      Padding temp = Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Image.network(
          imagem,
          fit: BoxFit.cover,
          height: 200,
        ),
      );
      imagens.add(temp);
    }
    return imagens;
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const TextTitle(
            title: 'Vamos achar sua próxima leitura!',
          ),

          //Seção de categorias
          const CategorySection(),

          // Categories row
          const CategoryBooks(),

          // Section title: Últimos livros doados
          const TextTitle(
            title: 'Últimos livros doados',
          ),

          StreamBuilder(
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
                shrinkWrap: true,
                primary: false,
                itemCount: documentos.length,
                itemBuilder: (context, index) {
                  ModelDonation postagem =
                      ModelDonation.fromDocument(documentos[index]);

                  return Card(
                    margin: const EdgeInsets.only(left: 16, right: 16),
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
                              const Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: CircleAvatar(
                                  //backgroundImage:
                                  //  NetworkImage(postagem.perfil!),
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

                          //Conteúdo da postagem
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        '${(documentos[index]['title'])}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
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
                                          color: AppLiterArtTheme.violetDark,
                                        ),
                                      ),
                                      backgroundColor:
                                          AppLiterArtTheme.violetLigth2,
                                      side:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Chip(
                                      label: Text(
                                        documentos[index]['pageNumber']!
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppLiterArtTheme.violetDark,
                                        ),
                                      ),
                                      backgroundColor:
                                          AppLiterArtTheme.violetLigth2,
                                      side:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BookDetailPage(
                                                  title: documentos[index][
                                                      'title'], // Passa o título do livro
                                                  author: documentos[index][
                                                      'author'], // Passa o autor do livro
                                                  coverImage: postagem
                                                      .bookCover!, // Passa a imagem da capa
                                                  synopsis: documentos[index]
                                                          ['synopsis'] ??
                                                      'Descrição não disponível', // Passa a descrição, se disponível
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: sizeOf.width * 0.53,
                                            height: sizeOf.height * 0.04,
                                            decoration: const BoxDecoration(
                                              color:
                                                  AppLiterArtTheme.violetButton,
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(16),
                                                  topLeft: Radius.circular(16)),
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
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
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
