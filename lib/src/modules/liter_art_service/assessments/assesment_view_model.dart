/*import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AssessmentViewModel {
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
*/

import 'dart:io';
import 'package:app_liter_art/src/model/models.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:app_liter_art/src/repositories/services/firestore/firestore_service_assessment.dart';

class AssessmentViewModel {
  // FormKey e TextControllers para o formulário
  final formKey = GlobalKey<FormState>();
  final titleEC = TextEditingController();
  final authorEC = TextEditingController();
  final categoryEC = TextEditingController();
  final pageNumberEC = TextEditingController();
  final pagesReadEC = TextEditingController();
  final assessmentEC = TextEditingController();

  // Signal para observar mudanças na imagem selecionada
  final Signal<File?> selectedImage = signal<File?>(null);

  // Estado de carregamento
  final Signal<bool> isLoading = signal(false);

  // Configurações de categorias e nota
  final List<String> mainCategories = [
    'Aventura',
    'Autoajuda',
    'Educação',
    'Fantasia',
    'Ficção',
    'Suspense',
    'Romance',
    'Terror'
  ];
  String? selectedCategory;
  double rating = 0.0;

  // Inicializa dados do livro a partir da API (se aplicável)
  void initializeData(bool isFromApi, Item? book) {
    if (isFromApi && book != null) {
      titleEC.text = book.volumeInfo.title;
      authorEC.text = book.volumeInfo.authors.join(", ");
      pageNumberEC.text = book.volumeInfo.pageCount.toString();
      selectedCategory = book.volumeInfo.categories != null &&
              mainCategories.contains(book.volumeInfo.categories!.first)
          ? book.volumeInfo.categories!.first
          : 'Outros';
    }
  }

  // Método para seleção de imagem da galeria
  Future<void> pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  // Validação do formulário
  bool validateForm({String? apiImageUrl}) {
    final isFormValid = formKey.currentState?.validate() ?? false;
    final hasImage = selectedImage.value != null || apiImageUrl != null;
    return isFormValid && hasImage;
  }

  // Atualiza a nota da avaliação
  void updateRating(double newRating) {
    rating = newRating;
  }

  // Função para enviar a avaliação ao Firestore
  Future<void> submitAssessment(BuildContext context,
      {String? apiImageUrl}) async {
    if (!validateForm(apiImageUrl: apiImageUrl)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Por favor, preencha todos os campos e selecione uma imagem.')),
      );
      return;
    }

    // Mostra o indicador de carregamento
    isLoading.value = true;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userId = auth.currentUser?.uid;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao obter o ID do usuário.')),
      );
      isLoading.value = false;
      return;
    }

    try {
      // Upload da imagem e obtenção da URL
      String? coverImageUrl = apiImageUrl;
      if (selectedImage.value != null) {
        coverImageUrl = await _uploadImage(userId);
      }

      // Envio da avaliação ao Firestore
      await FirestoreServiceAssessment().createAssessment(
        userUid: userId,
        title: titleEC.text,
        authors: authorEC.text,
        bookCover: coverImageUrl,
        category: selectedCategory,
        pageNumber: int.tryParse(pageNumberEC.text) ?? 0,
        comment: assessmentEC.text,
        note: rating,
        pagesRead: int.tryParse(pagesReadEC.text) ?? 0,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Avaliação criada com sucesso!')),
      );

      // Navegação para a página de confirmação após o sucesso
      Navigator.of(context).pushReplacementNamed('/confirmation');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar a avaliação: $e')),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Função privada para upload de imagem no Firebase Storage
  Future<String?> _uploadImage(String userId) async {
    if (selectedImage.value == null) return null;

    try {
      final storageRef = FirebaseStorage.instance.ref().child(
          '$userId/assessments/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = await storageRef.putFile(selectedImage.value!);

      if (uploadTask.state == TaskState.success) {
        return await storageRef.getDownloadURL();
      }
    } catch (e) {
      print("Erro ao fazer upload da imagem: $e");
    }
    return null;
  }

  // Método auxiliar para atualizar a categoria selecionada
  void onCategoryChanged(String? value) {
    selectedCategory = value;
  }

  // Validação de dropdown
  String? validateDropdown(String? value, String error) {
    return (value == null || value.isEmpty) ? error : null;
  }

  // Descarte dos recursos ao finalizar o ViewModel
  void dispose() {
    titleEC.dispose();
    authorEC.dispose();
    categoryEC.dispose();
    pageNumberEC.dispose();
    pagesReadEC.dispose();
    assessmentEC.dispose();
    selectedImage.dispose();
    isLoading.dispose();
  }
}
