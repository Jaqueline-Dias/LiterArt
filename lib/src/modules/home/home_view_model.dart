import 'package:app_liter_art/src/modules/feed/feed.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class HomeViewModel {
  // Gerencia a aba atual selecionada
  final currentTab = signal<int>(0);

  // Tabs e suas posições para a linha animada
  final List<String> tabs = ['Doações', 'Pedidos', 'Avaliações', 'Chat'];
  final Map<int, double> tabPosition = {0: 0, 1: 78, 2: 172, 3: 263};
  final Map<int, double> tabWidth = {0: 80, 1: 80, 2: 80, 3: 50};

  // Atualiza a aba atual
  void setCurrentTab(int index) {
    currentTab.value = index;
  }

  // Retorna o widget correspondente à aba atual
  Widget getPageContent() {
    switch (currentTab.value) {
      case 0:
        return const FeedDonationPage();
      case 1:
        return const FeedRequestPage();
      case 2:
        return const FeedAssessmentPage();
      case 3:
        return const FeedMessagePage();
      default:
        return const FeedDonationPage();
    }
  }

  // Retorna a posição da linha animada para a aba atual
  double getLinePosition() => tabPosition[currentTab.value] ?? 0;

  // Retorna a largura do contêiner para a linha animada
  double getContainerWidth() => tabWidth[currentTab.value] ?? 0;
}
