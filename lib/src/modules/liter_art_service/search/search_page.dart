import 'dart:async';
import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/model/models.dart';
import 'package:app_liter_art/src/modules/widgets/widgets.dart';
import 'package:app_liter_art/src/responsive/mobile_scaffold.dart';
import 'package:app_liter_art/src/repositories/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  final BookService bookService = BookService();

  List<Item> foundBooks = [];
  Timer? debounce;
  bool isLoading = false;
  bool hasStartedSearch = false;

  void _startSearchWithDebounce(String query) {
    if (!hasStartedSearch) {
      setState(() {
        hasStartedSearch = true;
      });
    }

    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce =
        Timer(const Duration(milliseconds: 400), () => searchBooks(query));
  }

  void searchBooks(String query) async {
    if (query.isEmpty) {
      _resetSearch();
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await bookService.getAllBooks(query);
      if (mounted) {
        setState(() {
          foundBooks = response;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Erro ao buscar livros. Tente novamente.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void _resetSearch() {
    setState(() {
      foundBooks = [];
      isLoading = false;
      hasStartedSearch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final customPadding = size * 0.017;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BottomNavigatorAppBar(),
        title: const Text(
          'Busca de livros',
          style: AppLiterArtTheme.textInfoAppBar,
        ),
        actions: const [
          Text(
            'Novo',
            style: AppLiterArtTheme.textInfoSearch,
          ),
          WidgetModalOptionsBook(
            isFromApi: false,
            icon: Icons.menu_book_rounded,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            _buildSearchField(size),
            if (isLoading)
              _buildLoadingWidget()
            else
              _buildResultsWidget(customPadding),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(double size) {
    return Center(
      child: SizedBox(
        width: size < 500 ? size * 0.9 : size * 0.95,
        child: TextField(
          onChanged: _startSearchWithDebounce,
          controller: searchController,
          textCapitalization: TextCapitalization.sentences,
          style: const TextStyle(color: AppLiterArtTheme.grey),
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
              color: AppLiterArtTheme.violetButton,
              fontSize: size < 500 ? 14 : 16,
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppLiterArtTheme.violetLigth2,
            contentPadding: EdgeInsets.symmetric(
              vertical: size < 500 ? 10.0 : 12.0,
              horizontal: 20.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return AlertDialog(
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
    );
  }

  Widget _buildResultsWidget(double padding) {
    if (!hasStartedSearch) {
      // Exibir imagem padrão antes de iniciar a pesquisa
      return const ImageDefault(
        imageDeafult: 'assets/images/interface-searching-01-8.svg',
        textInfo1: 'Os resultados aparecerão aqui!',
        textInfo2: 'Digite para buscar livros...',
      );
    }
    return foundBooks.isNotEmpty
        ? SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ResponsiveLayout(
              mobileScaffold: MobileScaffold(bookItems: foundBooks),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: const EmptyResultsWidget(
              message: 'Sem resultados por enquanto... Busque novamente!',
            ),
          );
  }
}
