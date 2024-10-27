import 'package:app_liter_art/src/modules/home/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Ajuda'),
      ),
      body: Container(),
    );
  }
}