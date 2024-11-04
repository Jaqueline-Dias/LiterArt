import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class RequestViewModel {
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
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

  // Método para fazer upload da imagem para o Firebase Storage
  Future<String?> uploadImage(String userId, File imageFile) async {
    try {
      // Define o caminho e o nome do arquivo com base no userId e timestamp
      final String fileName = basename(imageFile.path);
      final Reference storageRef =
          _storage.ref().child('user_uploads/$userId/donations/$fileName');

      // Faz o upload da imagem
      final UploadTask uploadTask = storageRef.putFile(imageFile);

      // Aguarda a conclusão do upload
      final TaskSnapshot snapshot = await uploadTask;

      // Obtém a URL da imagem carregada
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Erro ao fazer upload da imagem: $e");
      return null;
    }
  }
}
