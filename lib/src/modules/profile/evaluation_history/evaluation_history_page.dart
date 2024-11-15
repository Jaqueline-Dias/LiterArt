import 'package:app_liter_art/src/modules/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class EvaluationHistoryPage extends StatelessWidget {
  const EvaluationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Suas avaliações'),
      ),
      body: Container(),
    );
  }
}
