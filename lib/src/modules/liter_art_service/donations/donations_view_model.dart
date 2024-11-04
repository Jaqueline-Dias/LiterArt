import 'dart:io';
import 'package:image_picker/image_picker.dart';

class DonationsViewModel {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
    }
  }

  String? validateDropdown(String? value, String error) {
    return (value == null || value.isEmpty) ? error : null;
  }
}
