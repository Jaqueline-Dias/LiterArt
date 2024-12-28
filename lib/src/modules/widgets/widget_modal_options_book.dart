import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/model/models.dart';
import 'package:app_liter_art/src/modules/widgets/list_tile_drawer.dart';
import 'package:app_liter_art/src/modules/liter_art_service/assessments/assessment_page.dart';
import 'package:app_liter_art/src/modules/liter_art_service/donations/donation_page.dart';
import 'package:app_liter_art/src/modules/liter_art_service/requests/request_page.dart';
import 'package:app_liter_art/src/modules/liter_art_service/search/widgets/widget_conatiner_bookshelf.dart';
import 'package:flutter/material.dart';

class WidgetModalOptionsBook extends StatelessWidget {
  const WidgetModalOptionsBook(
      {super.key, this.book, this.icon, this.text, required this.isFromApi});

  final Item? book;
  final IconData? icon;
  final String? text;
  final bool isFromApi;

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return TextButton.icon(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, // Para modal em tela cheia
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(65),
            ),
          ),
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: sizeOf.height * 0.6,
                    width: sizeOf.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(65),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Text(
                              'O que você deseja fazer com este livro?',
                              style: LAAppTheme.titleSubDescription,
                            ),
                          ),
                          const Divider(),
                          ListTileDrawer(
                            size: const EdgeInsets.only(bottom: 8),
                            image: LAImages.iconDonation,
                            title: 'Quero doar este livro físico',
                            onTap: () {
                              Navigator.of(context).pop(); // Fecha o modal
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DonationPage(
                                    book: book,
                                    isFromApi: isFromApi,
                                  ),
                                ),
                              );
                            },
                          ),
                          ListTileDrawer(
                            size: const EdgeInsets.only(bottom: 8),
                            image: 'assets/images/bookmark-add.svg',
                            title: 'Quero pedir a doação deste livro',
                            onTap: () {
                              Navigator.of(context).pop(); // Fecha o modal
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RequestPage(
                                    book: book,
                                    isFromApi: isFromApi,
                                  ),
                                ),
                              );
                            },
                          ),
                          ListTileDrawer(
                            size: const EdgeInsets.only(bottom: 8),
                            image: LAImages.iconAssessment,
                            title: 'Quero avaliar esta obra literária',
                            onTap: () {
                              Navigator.of(context).pop(); // Fecha o modal
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AssessmentPage(
                                    book: book,
                                    isFromApi: isFromApi,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          const Text(
                            'Adicionar a minha estante',
                            style: LAAppTheme.titleSubDescription,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              WidgetConatinerBookshelf(
                                image: 'assets/images/bookmark-minus.svg',
                                onTap: () {},
                                title: 'Estou lendo',
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              WidgetConatinerBookshelf(
                                image: 'assets/images/bookmark.svg',
                                onTap: () {},
                                title: 'Quero ler',
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              WidgetConatinerBookshelf(
                                image: 'assets/images/bookmark-check.svg',
                                onTap: () {},
                                title: 'Já li este livro',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: LAColors.buttonPrimary,
                        size: 32,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Fecha o modal
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      label: Text(text ?? '', style: LAAppTheme.textInfoSearch),
      icon: Icon(
        icon ?? Icons.add,
        size: 32,
        color: LAColors.buttonPrimary,
      ),
    );
  }
}
