import 'dart:io';
import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:app_liter_art/src/modules/liter_art_service/donations/donations_view_model.dart';
import 'package:app_liter_art/src/modules/liter_art_service/donations/widgets/donation_registration_confirm.dart';
import 'package:app_liter_art/src/modules/liter_art_service/donations/widgets/widget_gesture_detector.dart';
import 'package:app_liter_art/src/modules/liter_art_service/donations/widgets/widget_text_field.dart';
import 'package:app_liter_art/src/modules/widgets/widgets.dart';
import 'package:app_liter_art/src/repositories/services/firestore/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:validatorless/validatorless.dart';

class DonationConfirmationPage extends StatefulWidget {
  final String title;
  final String author;
  final String? category;
  final String pageNumber;
  final String? language;
  final String synopsis;
  final File? selectedImage;
  final String? apiImageUrl;

  const DonationConfirmationPage({
    super.key,
    required this.title,
    required this.author,
    this.category,
    required this.pageNumber,
    this.language,
    required this.synopsis,
    this.selectedImage,
    this.apiImageUrl,
  });

  @override
  State<DonationConfirmationPage> createState() =>
      _DonationConfirmationPageState();
}

class _DonationConfirmationPageState extends State<DonationConfirmationPage> {
  final DonationsViewModel _donationsViewModel = DonationsViewModel();
  final addressEC = TextEditingController();
  final FirestoreServiceDonation _firestoreServiceDonation =
      FirestoreServiceDonation();
  final List<File> _imagens = [];
  bool _isLoading = false;
  String? conservation;

  @override
  void dispose() {
    super.dispose();
    addressEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _isLoading
            ? null
            : AppBar(
                leading: const BottomNavigatorAppBar(),
                title: const Text(
                  'Nova doação',
                  style: LAAppTheme.textInfoAppBar,
                ),
                actions: const [
                  Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: Text(
                      '2/2',
                      style: LAAppTheme.textInfoAppBar,
                    ),
                  )
                ],
              ),
        body: _isLoading
            ? const WidgetLoadingPost()
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Escolha até três imagens deste livro',
                      style: LAAppTheme.textInfoSearch,
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: WidgetGestureDetector(
                              onTap: () => _pickImage(index),
                              child: _imagens.length > index
                                  ? Image.file(_imagens[index],
                                      width: 56, height: 56)
                                  : Container(
                                      padding: const EdgeInsets.all(42),
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: LAColors.accent,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/images/camera-01.svg',
                                      ),
                                    ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Estado de conservação',
                          style: LAAppTheme.textInfoSearch,
                        ),
                        const SizedBox(height: 8),
                        FormBuilderRadioGroup(
                          name: 'conservation',
                          options: ['Usado', 'Novo']
                              .map((lang) => FormBuilderFieldOption(
                                    value: lang,
                                    child: Text(lang),
                                  ))
                              .toList(growable: false),
                          validator:
                              Validatorless.required('Escolha uma opção'),
                          onChanged: (result) {
                            conservation = result.toString();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Endereço de entrega (Opcional)",
                      style: LAAppTheme.textInfoSearch,
                    ),
                    const SizedBox(height: 8),
                    WidgetTextField(
                      label: 'Endereço',
                      controller: addressEC,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_validateFields()) {
                          await _submitDonation(context);
                        }
                      },
                      child: const Text('Confirmar Doação'),
                    ),
                  ],
                ),
              ));
  }

  bool _validateFields() {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    bool isValid = true;

    // Verifica se pelo menos uma imagem foi selecionada
    if (_imagens.isEmpty && widget.selectedImage == null) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Selecione pelo menos uma imagem.'),
        ),
      );
      isValid = false;
    }

    // Verifica se o estado de conservação foi selecionado
    if (conservation == null) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Escolha o estado de conservação.'),
        ),
      );
      isValid = false;
    }

    return isValid;
  }

  String _gerarNome() {
    final now = DateTime.now();
    return now.millisecondsSinceEpoch.toString();
  }

  Future<String?> _uploadSelectedImage(String userId) async {
    if (widget.selectedImage == null) return null;

    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      Reference imageRef =
          storage.ref().child(userId).child('donations/${_gerarNome()}.jpg');
      final TaskSnapshot task = await imageRef.putFile(widget.selectedImage!);

      if (task.state == TaskState.success) {
        return await task.ref.getDownloadURL();
      }
    } catch (e) {
      print("Erro ao fazer upload da imagem selecionada: $e");
    }
    return null;
  }

  Future<List<String>?> _salvarFotosAdicionais(String userId) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaFotos = storage.ref().child(userId).child('donations');
    List<String> urls = [];

    try {
      for (File foto in _imagens) {
        final arquivo = pastaFotos.child("${_gerarNome()}.jpg");
        final TaskSnapshot task = await arquivo.putFile(foto);

        if (task.state == TaskState.success) {
          String url = await task.ref.getDownloadURL();
          urls.add(url);
        }
      }
      return urls;
    } catch (e) {
      print("Erro ao salvar fotos adicionais: $e");
      return null;
    }
  }

  Future<void> _submitDonation(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String userId = auth.currentUser!.uid;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    setState(() {
      _isLoading = true;
    });

    // Upload da imagem de capa selecionada (se houver) e obtenção da URL
    String? coverImageUrl = widget.apiImageUrl;
    if (widget.selectedImage != null) {
      coverImageUrl = await _uploadSelectedImage(userId);
      if (coverImageUrl == null) {
        setState(() {
          _isLoading = false;
        });
        scaffoldMessenger.showSnackBar(
          const SnackBar(
              content:
                  Text('Erro ao enviar a imagem de capa. Tente novamente.')),
        );
        return;
      }
    }

    // Upload das imagens adicionais
    List<String>? additionalPhotos = await _salvarFotosAdicionais(userId);
    if (additionalPhotos == null) {
      setState(() {
        _isLoading = false;
      });
      scaffoldMessenger.showSnackBar(
        const SnackBar(
            content:
                Text('Erro ao enviar imagens adicionais. Tente novamente.')),
      );
      return;
    }

    // Envia a doação para o Firestore
    try {
      await _firestoreServiceDonation.createDonation(
        userUid: userId,
        title: widget.title,
        authors: widget.author,
        bookCover: coverImageUrl, // Usa a URL da capa após o upload
        category: widget.category,
        pageNumber: int.tryParse(widget.pageNumber),
        language: widget.language,
        synopsis: widget.synopsis,
        conservation: conservation,
        photos: additionalPhotos,
        address: addressEC.text,
      );

      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Doação criada com sucesso!')),
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const DonationRegistrationConfirm()),
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Erro ao criar doação: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImage([int? index]) async {
    await _donationsViewModel.pickImageFromGallery();
    if (_donationsViewModel.selectedImage != null) {
      setState(() {
        if (index != null && index < _imagens.length) {
          _imagens[index] = _donationsViewModel.selectedImage!;
        } else if (index != null && index >= _imagens.length) {
          _imagens.add(_donationsViewModel.selectedImage!);
        } else if (_imagens.length < 3) {
          _imagens.add(_donationsViewModel.selectedImage!);
        }
      });
    }
  }
}
