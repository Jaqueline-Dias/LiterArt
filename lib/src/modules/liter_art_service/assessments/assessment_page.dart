import 'package:app_liter_art/src/model/models.dart';
import 'package:flutter/material.dart';

class AssessmentPage extends StatelessWidget {
  const AssessmentPage({super.key, this.book});

  final Item? book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina de avaliações'),
      ),
      body: Container(),
    );
  }
}
