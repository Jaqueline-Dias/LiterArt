import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/modules/profile/gamification/gamification_view_model.dart';
import 'package:app_liter_art/src/modules/profile/gamification/widgets/my_achievements.dart';
import 'package:app_liter_art/src/modules/profile/gamification/widgets/all_titles.dart';
import 'package:flutter/material.dart';

class GamificationPage extends StatefulWidget {
  const GamificationPage({super.key, required this.userUid});

  final String userUid;

  @override
  State<GamificationPage> createState() => _GamificationPageState();
}

class _GamificationPageState extends State<GamificationPage> {
  GamificationViewModel viewModel = GamificationViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: LAColors.buttonPrimary,
            size: 32,
          ),
        ),
        title: const Text(LATexts.myAchievements),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Abas de navegação
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTab(LATexts.myTitles, 0),
                _buildTab(LATexts.allTitles, 1),
              ],
            ),
            // Conteúdo da aba selecionada
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            viewModel.selectedTabIndex = index;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: LASizes.sm),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: viewModel.selectedTabIndex == index
                  ? LAColors.primary
                  : LAColors.darkGrey,
              fontWeight: viewModel.selectedTabIndex == index
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (viewModel.selectedTabIndex) {
      case 0:
        return StreamBuilder<int>(
          stream: viewModel.getPointsStream(widget.userUid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(LATexts.onBoardingTitle1),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text(LATexts.onBoardingTitle2),
              );
            }
            return MyAchievements(points: snapshot.data!);
          },
        );
      case 1:
        return const AllTitles();
      default:
        return Container();
    }
  }
}
