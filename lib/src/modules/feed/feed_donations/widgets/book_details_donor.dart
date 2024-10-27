import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookDetailsDonor extends StatefulWidget {
  const BookDetailsDonor(
      {super.key, required this.profile, required this.userUid});

  final String profile;
  final String userUid;

  @override
  State<BookDetailsDonor> createState() => _BookDetailsDonorState();
}

class _BookDetailsDonorState extends State<BookDetailsDonor> {
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

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        const Text(
          'Quem está doando este livro',
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.profile),
              radius: 24,
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Usa FutureBuilder para aguardar o nome do usuário
                FutureBuilder<String>(
                  future: _getUserName(widget.userUid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Erro ao carregar');
                    } else {
                      return Text(snapshot.data ?? 'Usuário desconhecido');
                    }
                  },
                ),
                //GAMIFICAÇÃO
                const Text('Mestre da imaginação'),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        const Divider(),
        const SizedBox(
          height: 32,
        ),
        Row(
          children: [
            const Text('Sobre a entrega'),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: sizeOf.height,
                          width: sizeOf.width,
                          child: const Padding(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sobre o recebimento da doação',
                                  style: AppLiterArtTheme.titleSubDescription,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  'O aplicativo Bookshelf não se responsabiliza pela entrega das doações. Oferecemos um ambiente de chat para que você possa combinar com o doador as formas de entrega e recebimento do livro. Cuidado ao conversar com estranhos!',
                                  textAlign: TextAlign.justify,
                                  style: AppLiterArtTheme.titleDescription,
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                icon: const Icon(
                  Icons.info,
                  color: AppLiterArtTheme.violetLigth,
                ))
          ],
        ),
        const SizedBox(
          height: 32,
        ),
        const Text(
            'Este usuário não informou um endereço. Entre em contato através do chat.'),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
