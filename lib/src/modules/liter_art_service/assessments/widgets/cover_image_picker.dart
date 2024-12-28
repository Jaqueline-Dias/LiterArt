import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:app_liter_art/src/model/models.dart';
import 'package:app_liter_art/src/modules/liter_art_service/assessments/assesment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:signals_flutter/signals_flutter.dart';

class CoverImagePicker extends StatelessWidget {
  final AssessmentViewModel viewModel;
  final Item? book;

  const CoverImagePicker({
    super.key,
    required this.viewModel,
    this.book,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await viewModel.pickImageFromGallery();
      },
      child: Watch(
        (_) {
          final selectedImage = viewModel.selectedImage.value;

          if (selectedImage != null) {
            return Image.file(
              selectedImage,
              fit: BoxFit.cover,
              height: 180,
            );
          } else if (book?.volumeInfo.imageLinks.thumbnail != null) {
            return Image.network(
              book!.volumeInfo.imageLinks.thumbnail!,
              fit: BoxFit.cover,
              height: 180,
            );
          } else {
            return PlaceholderImage(isImageSelected: selectedImage != null);
          }
        },
      ),
    );
  }
}

class PlaceholderImage extends StatelessWidget {
  final bool isImageSelected;

  const PlaceholderImage({super.key, required this.isImageSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 122,
      height: 180,
      decoration: BoxDecoration(
        color: LAColors.accent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/camera-01.svg',
            colorFilter: ColorFilter.mode(
              isImageSelected ? LAColors.buttonPrimary : Colors.red,
              BlendMode.srcIn,
            ),
          ),
          if (!isImageSelected)
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                textAlign: TextAlign.center,
                'Capa obrigatória!',
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
