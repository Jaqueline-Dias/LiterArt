class GamificationViewModel {
  // Função para retornar o título com base nos pontos
  String getTitle(int points) {
    if (points >= 650) {
      return 'Mestre da imaginação';
    } else if (points >= 550) {
      return 'Escultor de sonhos';
    } else if (points >= 450) {
      return 'Alquimista da leitura';
    } else if (points >= 350) {
      return 'Mágico das palavras';
    } else if (points >= 250) {
      return 'Mestre das páginas';
    } else if (points >= 150) {
      return 'Caçador de tesouros';
    } else if (points >= 100) {
      return 'Conquistador de universos';
    } else if (points >= 50) {
      return 'Aprendiz de histórias';
    } else {
      return 'Sem título';
    }
  }

  // Função para retornar o caminho da medalha com base no título
  String getMedalAsset(String title) {
    switch (title) {
      case 'Mestre da imaginação':
        return 'assets/images/default_medal.svg';
      case 'Escultor de sonhos':
        return 'assets/images/default_medal.svg';
      case 'Alquimista da leitura':
        return 'assets/images/alquimista_medal.svg';
      case 'Mágico das palavras':
        return 'assets/images/magico01.svg';
      case 'Mestre das páginas':
        return 'assets/images/mestre.svg';
      case 'Caçador de tesouros':
        return 'assets/images/cacador.svg';
      case 'Conquistador de universos':
        return 'assets/images/conquistador01.svg';
      case 'Aprendiz de histórias':
        return 'assets/images/aprendiz.svg';
      default:
        return 'assets/images/default_medal.svg'; // Medalha padrão ou genérica
    }
  }
}
