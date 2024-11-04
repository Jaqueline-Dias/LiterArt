import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/model/models.dart';
import 'package:app_liter_art/src/modules/screen/book_detail_screen.dart';
import 'package:app_liter_art/src/modules/widgets/authors_list_widget.dart';
import 'package:app_liter_art/src/modules/widgets/book_button_info_widget.dart';
import 'package:flutter/material.dart';

class BookDetailWidget extends StatelessWidget {
  final Item book;

  const BookDetailWidget({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          book.volumeInfo.title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 5.0),
        AuthorsListWidget(
          currentAuthors: book.volumeInfo.authors,
        ),
        const SizedBox(height: 5.0),
        book.volumeInfo.publishedDate != ''
            ? Text(
                book.volumeInfo.publishedDate,
                style: AppLiterArtTheme.authorMobileDateStyle,
              )
            : const Text(
                'Data de pubicação desconhecida.',
                style: AppLiterArtTheme.authorMobileDateStyle,
              ),
        const SizedBox(height: 5.0),
        BookButtonInfoWidget(
          text: 'Ver mais detalhes',
          onPressedFn: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BookDetailScreen(
                book: book,
              ),
            ),
          ),
          icon: Icons.arrow_forward_ios_rounded,
          btnColor: AppLiterArtTheme.violetDark,
        ),
      ],
    );
  }
}
