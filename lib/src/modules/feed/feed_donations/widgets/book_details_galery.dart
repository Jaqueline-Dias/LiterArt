import 'package:flutter/material.dart';

class BookDetailsGalery extends StatefulWidget {
  const BookDetailsGalery({super.key, this.photos});
  final dynamic photos;

  @override
  State<BookDetailsGalery> createState() => _BookDetailsGaleryState();
}

class _BookDetailsGaleryState extends State<BookDetailsGalery> {
  List<Widget> _carrossel(List<dynamic> fotos) {
    List<Widget> imagens = List.empty(growable: true);
    for (String imagem in fotos) {
      Padding temp = Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Image.network(
          imagem,
          fit: BoxFit.cover,
          height: 300,
        ),
      );
      imagens.add(temp);
    }
    return imagens;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _carrossel(widget.photos),
          ),
        ),
      ),
    );
  }
}
