import 'package:flutter/material.dart';
import 'package:app_liter_art/src/modules/liter_art_service/assessments/assesment_view_model.dart';

class ConfirmButton extends StatelessWidget {
  final AssessmentViewModel viewModel;

  const ConfirmButton({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await viewModel.submitAssessment(context);
      },
      child: const Text('Confirmar Avaliação'),
    );
  }
}
