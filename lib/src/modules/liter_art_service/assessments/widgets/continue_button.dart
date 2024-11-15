import 'package:app_liter_art/src/model/models.dart';
import 'package:app_liter_art/src/modules/liter_art_service/assessments/assesment_view_model.dart';
import 'package:app_liter_art/src/modules/liter_art_service/assessments/assessment_confirmation_page.dart';
import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final AssessmentViewModel viewModel;
  final Item? book;

  const ContinueButton({
    super.key,
    required this.viewModel,
    this.book,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Verifica se o formulário e a imagem (local ou API) são válidos
        if (viewModel.validateForm(
            apiImageUrl: book?.volumeInfo.imageLinks.thumbnail)) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AssessmentConfirmationPage(
                title: viewModel.titleEC.text,
                author: viewModel.authorEC.text,
                category: viewModel.selectedCategory,
                pageNumber: int.tryParse(viewModel.pageNumberEC.text) ?? 0,
                selectedImage: viewModel.selectedImage.value,
                apiImageUrl: book?.volumeInfo.imageLinks.thumbnail,
                pagesRead: int.tryParse(viewModel.pagesReadEC.text) ?? 0,
              ),
            ),
          );
        } else {
          // Exibe a mensagem de erro caso não haja imagem ou o formulário esteja inválido
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Por favor, preencha todos os campos e selecione uma imagem.'),
            ),
          );
        }
      },
      child: const Text('Continuar'),
    );
  }
}
