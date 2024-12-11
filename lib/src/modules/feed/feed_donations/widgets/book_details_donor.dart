import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:flutter/material.dart';

class BookDetailsDonor extends StatefulWidget {
  const BookDetailsDonor(
      {super.key,
      required this.profilePicture,
      required this.userUid,
      required this.nickname});

  final String profilePicture;
  final String userUid;
  final String nickname;

  @override
  State<BookDetailsDonor> createState() => _BookDetailsDonorState();
}

class _BookDetailsDonorState extends State<BookDetailsDonor> {
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
              backgroundImage: NetworkImage(widget.profilePicture),
              radius: 24,
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.nickname),
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
                                  style: LAAppTheme.titleSubDescription,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  'O aplicativo Bookshelf não se responsabiliza pela entrega das doações. Oferecemos um ambiente de chat para que você possa combinar com o doador as formas de entrega e recebimento do livro. Cuidado ao conversar com estranhos!',
                                  textAlign: TextAlign.justify,
                                  style: LAAppTheme.titleDescription,
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                icon: const Icon(
                  Icons.info,
                  color: LAColors.secondary,
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
