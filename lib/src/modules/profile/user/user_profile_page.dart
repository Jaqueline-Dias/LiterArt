import 'package:app_liter_art/src/modules/home/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Container(),
    );
  }
}
