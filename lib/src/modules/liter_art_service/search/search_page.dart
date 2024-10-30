import 'dart:async';
import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/model/models.dart';
import 'package:app_liter_art/src/modules/liter_art_service/search/widgets/responsive_layout.dart';
import 'package:app_liter_art/src/responsive/mobile_scaffold.dart';
import 'package:app_liter_art/src/services/book_service.dart';
import 'package:app_liter_art/src/widgets/empty_results_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  List<Item> foundBooks = []; //Lista que armazena os resultados da busca.
  BookService bookService =
      BookService(); //Instância de um serviço que busca livros.
  Timer?
      debounce; //Temporizador para adiar a busca (evitando consultas a cada caractere digitado).
  bool isLoading = false; //Indica se os resultados ainda estão carregando.

  //Este método é executado toda vez que o texto do campo de busca é alterado.
  void searchBooks(String query) async {
    if (debounce?.isActive ?? false) debounce?.cancel();
    if (query.isEmpty) {
      setState(() {
        foundBooks = [];
        isLoading = false;
      });
      return;
    }
    debounce = Timer(const Duration(milliseconds: 400), () async {
      setState(() => isLoading = true);
      final response = await bookService.getAllBooks(query);
      setState(() {
        isLoading = false;
        foundBooks = response;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    double customPadding = size * 0.017;
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Busca de livros',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          const Text(
            'Novo',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            width: 8,
          ),
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
                            Text('Opção 222'),
                            Text('Opção 222'),
                            Text('Opção 222'),
                            Text('Opção 222'),
                            Text('Opção 222'),
                          ],
                        ),
                      ),
                    );
                  });
            },
            icon: const Icon(Icons.menu_book_rounded, size: 32),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: SizedBox(
              width: size < 500 ? size * 0.9 : size * 0.95,
              //Campo de pesquisa.
              child: TextField(
                onChanged: searchBooks,
                controller: searchController,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(
                  color: AppLiterArtTheme.grey,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: const Color(0xFF7A15B2).withOpacity(0.7),
                    size: size < 500 ? 28.0 : 35.0,
                  ),
                  hintText: 'Pesquise por títulos ou autores aqui...',
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintStyle: TextStyle(
                    color: AppLiterArtTheme.greyLigth,
                    fontSize: size < 500 ? 14 : 16,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppLiterArtTheme.violetLigth2,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: size < 500 ? 10.0 : 12.0, horizontal: 20.0),
                ),
              ),
            ),
          ),

          //Exibição Condicional dos Resultados.
          if (isLoading)
            AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Os resultados irão aparecer aqui... 😃'),
              content: Lottie.asset(
                'assets/book-search.json',
                width: 200,
                height: 200,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            )
          else if (foundBooks.isNotEmpty)
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ResponsiveLayout(
                mobileScaffold: MobileScaffold(bookItems: foundBooks),
              ),
            )
          else
            Padding(
              padding:
                  EdgeInsets.only(left: customPadding, right: customPadding),
              child: const EmptyResultsWidget(
                message: 'Sem resultados por enquanto... Busque novamente!',
              ),
            )
        ],
      ),
    );
  }
}
