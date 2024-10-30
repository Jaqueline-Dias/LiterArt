import 'dart:convert';
import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils.dart';
import 'package:app_liter_art/src/model/models.dart';
import 'package:app_liter_art/src/widgets/authors_list_widget.dart';
import 'package:app_liter_art/src/widgets/background_widget.dart';
import 'package:app_liter_art/src/widgets/book_button_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:transparent_image/transparent_image.dart';

class BookDetailScreen extends StatefulWidget {
  final Item book;

  const BookDetailScreen({
    super.key,
    required this.book,
  });

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool isFavorite = false;
  List<String> savedFavBooks = [];

  void getFavoritesBooks() async {
    savedFavBooks = await Utils.getFavoritesBooks();
    List<Item> savedFavBooksParsed =
        savedFavBooks.map((map) => Item.fromApiItems(jsonDecode(map))).toList();
    setState(() => isFavorite =
        savedFavBooksParsed.any((book) => book.id == widget.book.id));
  }

  @override
  void initState() {
    getFavoritesBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool hasNotch = MediaQuery.of(context).viewPadding.top > 24;
    double separation = 1;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Text(
            'Detalhes do livro',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BackgroundWidget(
        color: Colors.white.withOpacity(0.75),
        child: Padding(
          padding: EdgeInsets.only(
            top: hasNotch ? 120.0 : 90.0,
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Hero(
                    tag: widget.book,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: widget.book.volumeInfo.imageLinks!.thumbnail,
                        fit: BoxFit.fill,
                        width: 180,
                        height: 250,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Text(
                              widget.book.volumeInfo.title,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            if (widget.book.volumeInfo.title.length > 26)
                              Positioned(
                                top: 52,
                                bottom: 0,
                                right: 0,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => showDialog(
                                      context: context,
                                      builder: ((context) => AlertDialog(
                                            title: Text(
                                              widget.book.volumeInfo.title,
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                                    ),
                                    child: const Icon(
                                      Icons.remove_red_eye,
                                      size: 20.5,
                                      color: Utils.darkYellowColor,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: separation),
                        AuthorsListWidget(
                          currentAuthors: widget.book.volumeInfo.authors,
                        ),
                        SizedBox(height: separation),
                        widget.book.volumeInfo.publishedDate != ''
                            ? Text(
                                widget.book.volumeInfo.publishedDate,
                                style: AppLiterArtTheme.authorMobileDateStyle,
                              )
                            : const Text(
                                'TESTE',
                                style: AppLiterArtTheme.authorMobileDateStyle,
                              ),
                        SizedBox(height: separation),
                        isFavorite
                            ? BookButtonInfoWidget(
                                text: 'Remover',
                                onPressedFn: () async {
                                  Utils.setFavoritesBooks(
                                      savedFavBooks, widget.book, "remove");
                                  setState(() => isFavorite = false);
                                },
                                icon: Icons.remove_circle_sharp,
                                btnColor: Utils.darkRedColor,
                              )
                            : BookButtonInfoWidget(
                                text: 'Adicionar',
                                onPressedFn: () async {
                                  Utils.setFavoritesBooks(
                                      savedFavBooks, widget.book, "add");
                                  setState(() => isFavorite = true);
                                },
                                icon: Icons.add_circle_sharp,
                                btnColor: AppLiterArtTheme.violetDark,
                              ),
                        SizedBox(height: separation),
                        BookButtonInfoWidget(
                          text: "Google Books info",
                          onPressedFn: () => Utils.getGoogleBooksInfo(
                              widget.book.id, widget.book.volumeInfo.title),
                          icon: Icons.arrow_forward_ios_rounded,
                          btnColor: AppLiterArtTheme.violetDark,
                        ),
                        SizedBox(height: separation),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              const Divider(
                color: Color(0xFF9C9C9C),
                thickness: 2.0,
              ),
              const SizedBox(height: 15.0),
              const Text(
                'Sinopse',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 15.0),
              Expanded(
                child: Scrollbar(
                  thickness: 5.0,
                  radius: const Radius.circular(5.0),
                  child: SingleChildScrollView(
                    child: Text(
                      widget.book.volumeInfo.description,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        height: 1.5,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppLiterArtTheme.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}