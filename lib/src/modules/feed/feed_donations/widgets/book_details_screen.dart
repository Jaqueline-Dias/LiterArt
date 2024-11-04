import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen(
      {super.key,
      required this.synopsis,
      required this.pageNumber,
      required this.category,
      required this.language,
      required this.conservation,
      required this.publicationDate});

  final String synopsis;
  final String category;
  final int pageNumber;
  final String language;
  final String conservation;
  final Timestamp publicationDate;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  final Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppLiterArtTheme.violetLigth2,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(widget.pageNumber.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppLiterArtTheme.violetDark)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text('Páginas',
                      style: TextStyle(color: AppLiterArtTheme.grey)),
                ],
              ),
              Column(
                children: [
                  Text(widget.language,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppLiterArtTheme.violetDark)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text('Idioma',
                      style: TextStyle(color: AppLiterArtTheme.grey)),
                ],
              ),
              Column(
                children: [
                  Text(widget.category,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppLiterArtTheme.violetDark)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text('Categoria',
                      style: TextStyle(color: AppLiterArtTheme.grey)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text('Doado em: ${utils.formatDate(widget.publicationDate)}',
            style: const TextStyle(color: AppLiterArtTheme.grey)),
        Text('Estado de conservação: ${widget.conservation}',
            style: const TextStyle(color: AppLiterArtTheme.grey)),
        const SizedBox(height: 16),
        const Text('Sinopse',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppLiterArtTheme.grey)),
        const SizedBox(height: 8),
        Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Text(
              widget.synopsis,
              textAlign: TextAlign.justify,
              style: const TextStyle(color: AppLiterArtTheme.grey),
            ),
          ),
        ),
      ],
    );
  }
}
