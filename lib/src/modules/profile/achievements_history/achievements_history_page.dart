import 'package:app_liter_art/src/modules/home/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class AchievementsHistoryPage extends StatelessWidget {
  const AchievementsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Minhas conquistas'),
      ),
      body: Container(),
    );
  }
}
