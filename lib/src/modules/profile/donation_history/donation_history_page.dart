import 'package:app_liter_art/src/modules/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class DonationHistoryPage extends StatelessWidget {
  const DonationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Suas doações'),
      ),
      body: Container(),
    );
  }
}
