import 'package:flutter/material.dart';

class HomeViewModel {
  Future<void> showExitConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar saída"),
          content: const Text("Tem certeza de que deseja sair do App?"),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Sair"),
            ),
          ],
        );
      },
    );
  }
}
