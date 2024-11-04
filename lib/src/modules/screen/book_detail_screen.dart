import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils.dart';
import 'package:app_liter_art/src/model/models.dart';
import 'package:app_liter_art/src/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    bool hasNotch = MediaQuery.of(context).viewPadding.top > 24;
    double separation = 1;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BottomNavigatorAppBar(),
        title: const Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Text(
            'Detalhes do livro',
            style: AppLiterArtTheme.textInfoAppBar,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
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
                    child: widget.book.volumeInfo.imageLinks.thumbnail != null
                        ? FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: widget.book.volumeInfo.imageLinks.thumbnail!,
                            fit: BoxFit.fill,
                            width: 180,
                            height: 250,
                          )
                        : Container(
                            width: 180,
                            height: 250,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BookButtonInfoWidget(
                        text: "Google Books",
                        onPressedFn: () => Utils.getGoogleBooksInfo(
                            widget.book.id, widget.book.volumeInfo.title),
                        icon: Icons.arrow_forward_ios_rounded,
                        btnColor: AppLiterArtTheme.violetDark,
                      ),
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
                              top: 16,
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
                                    color: AppLiterArtTheme.violet,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      //SizedBox(height: separation),
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
                              '',
                              style: AppLiterArtTheme.authorMobileDateStyle,
                            ),
                      const SizedBox(
                        height: 16,
                      ),
                      // Novo botão para navegar para o formulário de doação

                      WidgetModalOptionsBook(
                        isFromApi: true,
                        book: widget.book,
                        icon: Icons.add,
                        text: 'Adicionar',
                      ),
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
    );
  }
}
