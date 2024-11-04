import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BookDetailsGalery extends StatefulWidget {
  const BookDetailsGalery({super.key, this.photos});
  final dynamic photos;

  @override
  State<BookDetailsGalery> createState() => _BookDetailsGaleryState();
}

class _BookDetailsGaleryState extends State<BookDetailsGalery> {
  bool _isLoading = true;

  // Simula um carregamento inicial de 1 segundos antes de exibir as imagens
  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  List<Widget> _carrossel(List<dynamic> fotos) {
    return fotos.map((imagem) {
      return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: FadeInImage.assetNetwork(
          placeholder:
              'assets/images/carregamento.png', // Imagem de loading local
          image: imagem,
          fit: BoxFit.cover,
          height: 300,
          imageErrorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image,
                size: 100, color: Colors.grey);
          },
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: _isLoading
            ? const SizedBox(
                height: 300,
                child: SpinKitFadingCircle(
                  color: AppLiterArtTheme.violetButton,
                  size: 50.0,
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _carrossel(widget.photos),
                ),
              ),
      ),
    );
  }
}
