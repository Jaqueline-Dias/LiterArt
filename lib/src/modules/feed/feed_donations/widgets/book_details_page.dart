import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/modules/feed/feed_donations/widgets/book_details_donor.dart';
import 'package:app_liter_art/src/modules/feed/feed_donations/widgets/book_details_galery.dart';
import 'package:app_liter_art/src/modules/feed/feed_donations/widgets/book_details_screen.dart';
import 'package:app_liter_art/src/modules/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({
    super.key,
    required this.title,
    required this.authors,
    required this.coverImage,
    required this.synopsis,
    required this.pageNumber,
    required this.category,
    required this.language,
    required this.publicationDate,
    required this.conservation,
    required this.photos,
    required this.profilePicture,
    required this.userUid,
    required this.nickname,
  });

  final String title;
  final String authors;
  final String coverImage;
  final String synopsis;
  final String category;
  final String language;
  final dynamic photos;
  final int pageNumber;
  final Timestamp publicationDate;
  final String conservation;
  final String userUid;
  final String nickname; // Novo campo
  final String profilePicture;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BottomNavigatorAppBar(),
        title: const Text(
          'Detalhes do livro',
          style: AppLiterArtTheme.textInfoAppBar,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Exibe a imagem da capa
              Center(
                child: Image.network(
                  widget.coverImage,
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
              //título e autor
              const SizedBox(height: 16),
              Center(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Center(
                child: Text(
                  widget.authors,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 16),

              // Tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTab('Sobre o livro', 0),
                  _buildTab('Galeria', 1),
                  _buildTab('Doador', 2),
                ],
              ),
              // Conteúdo Dinâmico das Abas
              _buildTabContent(),

              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 24),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  label: const Text('Iniciar chat'),
                  icon: const Icon(
                    Icons.chat,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    return TextButton(
      onPressed: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Text(
        title,
        style: TextStyle(
          color: _selectedTabIndex == index
              ? AppLiterArtTheme.violetDark
              : Colors.grey,
          fontWeight:
              _selectedTabIndex == index ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

// Função para renderizar o conteúdo específico de cada aba
  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0: // Conteúdo da aba "Sobre o livro"
        return BookDetailsScreen(
          synopsis: widget.synopsis,
          pageNumber: widget.pageNumber,
          category: widget.category,
          language: widget.language,
          conservation: widget.conservation,
          publicationDate: widget.publicationDate,
        );

      case 1: // Conteúdo da aba "Galeria"
        return BookDetailsGalery(
          photos: widget.photos,
        );

      case 2: // Conteúdo da aba "Doador"
        return BookDetailsDonor(
          profilePicture: widget.profilePicture,
          userUid: widget.userUid,
          nickname: widget.nickname,
        );

      default:
        return Container();
    }
  }
}
