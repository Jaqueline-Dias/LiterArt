import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:app_liter_art/src/modules/profile/gamification/widgets/achievements_page.dart';
import 'package:app_liter_art/src/modules/profile/gamification/widgets/titles.dart';
import 'package:flutter/material.dart';

class GamificationPage extends StatefulWidget {
  const GamificationPage({super.key, required this.points});

  final int points;

  @override
  State<GamificationPage> createState() => _GamificationPageState();
}

class _GamificationPageState extends State<GamificationPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Minhas conquistas'),
        ),
        body: // Tabs
            Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTab('Meus títulos', 0),
                _buildTab('Todos os títulos', 1),
              ],
            ),
            _buildTabContent(),
          ],
        ));
  }

  Widget _buildTab(String title, int index) {
    return TextButton(
      onPressed: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Text(
          title,
          style: TextStyle(
            color:
                _selectedTabIndex == index ? LAColors.violetDark : Colors.grey,
            fontWeight: _selectedTabIndex == index
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return AchievementsPage(
          points: widget.points,
        );
      case 1:
        return const Titles();
      default:
        return Container();
    }
  }
}
