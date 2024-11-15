import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:app_liter_art/src/modules/liter_art_service/assessments/assesment_view_model.dart';

class RatingWidget extends StatelessWidget {
  final AssessmentViewModel viewModel;

  const RatingWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Atribuir uma nota',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Ruim", style: TextStyle(fontSize: 12)),
            Center(
              child: RatingBar.builder(
                initialRating: viewModel.rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.purple.shade300,
                ),
                onRatingUpdate: viewModel.updateRating,
              ),
            ),
            const Text("Bom", style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
