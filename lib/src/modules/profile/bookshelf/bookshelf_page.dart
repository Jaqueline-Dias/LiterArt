import 'package:app_liter_art/src/modules/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class BookshelfPage extends StatelessWidget {
  const BookshelfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Estante de livros'),
      ),
      body: Container(),
    );
  }
}
