import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
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
      body: Container(),
    );
  }
}
