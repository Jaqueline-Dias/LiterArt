import 'package:flutter/material.dart';
import 'package:app_liter_art/src/modules/liter_art_service/assessments/assesment_view_model.dart';

class CommentInputField extends StatelessWidget {
  final AssessmentViewModel viewModel;

  const CommentInputField({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Comentário avaliativo',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: viewModel.assessmentEC,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Deixe sua opinião a respeito desta obra...',
            filled: true,
            fillColor: Colors.purple.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
