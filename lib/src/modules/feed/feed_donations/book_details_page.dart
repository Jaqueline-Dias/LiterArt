import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final String title;
  final String author;
  final String coverImage;
  final String synopsis;
  const BookDetailPage({
    super.key,
    required this.title,
    required this.author,
    required this.coverImage,
    required this.synopsis,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do livro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                coverImage,
                fit: BoxFit.cover,
                height: 200,
              ),
            ), // Exibe a imagem da capa
            const SizedBox(height: 8),
            Center(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Center(
              child: Text(
                author,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 16),

            Text(synopsis), // Adicione a descrição do livro
          ],
        ),
      ),
    );
  }
}
