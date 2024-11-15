import 'dart:io';
import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/model/itens.dart';
import 'package:app_liter_art/src/modules/liter_art_service/donations/widgets/donation_registration_confirm.dart';
import 'package:app_liter_art/src/modules/liter_art_service/donations/widgets/widget_text_field.dart';
import 'package:app_liter_art/src/modules/liter_art_service/requests/request_view_model.dart';
import 'package:app_liter_art/src/modules/widgets/widgets.dart';
import 'package:app_liter_art/src/repositories/services/firestore/firestore_service_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validatorless/validatorless.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key, this.book, this.isFromApi});

  final Item? book;
  final bool? isFromApi;

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final FirestoreServiceRequest firestoreServiceRequest =
      FirestoreServiceRequest();
  final RequestViewModel requestViewModel = RequestViewModel();
  final _titleEC = TextEditingController();
  final _authorEC = TextEditingController();
  final _pageNumberEC = TextEditingController();
  final _descriptionEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isImageSelected = true;

  File? _selectedImage; // Para armazenar a imagem selecionada pelo usuário

  String? selectedLanguage;
  String? selectedCategory;

  final Map<String, String> categoryMapping = {
    'adventure': 'Aventura',
    'self-help': 'Autoajuda',
    'education': 'Educação',
    'fantasy': 'Fantasia',
    'fiction': 'Ficção',
    'suspense': 'Suspense',
    'romance': 'Romance',
    'horror': 'Terror',
    'gothic fiction': 'Terror'
  };
  final List<String> mainCategories = [
    'Aventura',
    'Autoajuda',
    'Educação',
    'Fantasia',
    'Ficção',
    'Suspense',
    'Romance',
    'Terror',
  ];
  final Map<String, String> languageMapping = {
    'pt': 'Português',
    'pt-BR': 'Português',
    'pt-br': 'Português',
    'pt-Br': 'Português',
    'en': 'Inglês',
    'es': 'Espanhol',
    'fr': 'Francês',
  };
  final List<String> mainLanguages = [
    'Português',
    'Inglês',
    'Espanhol',
    'Francês',
  ];

  // Função para abrir a galeria e selecionar uma imagem
  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isFromApi == true && widget.book != null) {
      _titleEC.text = widget.book?.volumeInfo.title ?? '';
      _authorEC.text = widget.book?.volumeInfo.authors.join(", ") ?? '';
      _pageNumberEC.text = widget.book?.volumeInfo.pageCount.toString() ?? '';

      // Define a categoria selecionada a partir dos dados da API
      if (widget.book?.volumeInfo.categories != null) {
        final apiCategory = widget.book!.volumeInfo.categories!.first;
        selectedCategory =
            categoryMapping[apiCategory.toLowerCase()] ?? 'Outros';

        final apiLanguage = widget.book?.volumeInfo.language ?? 'Não definido';
        selectedLanguage = languageMapping[apiLanguage] ?? 'Outro';
      }
    }
  }

  @override
  void dispose() {
    _titleEC.dispose();
    _authorEC.dispose();
    _pageNumberEC.dispose();
    _descriptionEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isLoading
          ? null
          : AppBar(
              leading: const BottomNavigatorAppBar(),
              title: const Text(
                'Nova solicitação',
                style: AppLiterArtTheme.textInfoAppBar,
              ),
            ),
      body: _isLoading
          ? const WidgetLoadingPost()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _pickImageFromGallery,
                        child: _selectedImage != null
                            ? Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                                height: 180,
                              )
                            : (widget.book?.volumeInfo.imageLinks.thumbnail !=
                                    null
                                ? Image.network(
                                    widget
                                        .book!.volumeInfo.imageLinks.thumbnail!,
                                    fit: BoxFit.cover,
                                    height: 180,
                                  )
                                : Container(
                                    width: 122,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: AppLiterArtTheme.violetLigth2,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/camera-01.svg',
                                          colorFilter: ColorFilter.mode(
                                            _isImageSelected
                                                ? AppLiterArtTheme.violetButton
                                                : Colors.red,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        if (!_isImageSelected)
                                          const Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              'Capa obrigatória!',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                      ],
                                    ),
                                  )),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DropdownButtonFormFieldLiterArt(
                            titleButton: 'Categoria',
                            title: 'Escolha uma categoria',
                            value: selectedCategory,
                            mainCategories: mainCategories,
                            valueDrop: 'Outros',
                            titleDrop: 'Outros',
                            onChanged: (value) {
                              selectedCategory = value!;
                            },
                            validator: (value) =>
                                requestViewModel.validateDropdown(
                                    value, 'Escolha uma categoria'),
                          ),
                          DropdownButtonFormFieldLiterArt(
                            titleButton: 'Idioma',
                            title: 'Escolha um idioma',
                            value: selectedLanguage,
                            mainCategories: mainLanguages,
                            valueDrop: 'Outro',
                            titleDrop: 'Outro',
                            onChanged: (value) {
                              selectedLanguage = value!;
                            },
                            validator: (value) => requestViewModel
                                .validateDropdown(value, 'Escolha um idioma'),
                          ),
                          WidgetTextField(
                            keyboardType: TextInputType.text,
                            label: 'Título',
                            controller: _titleEC,
                            validator:
                                Validatorless.required('Título obrigatório'),
                          ),
                          WidgetTextField(
                            keyboardType: TextInputType.text,
                            label: 'Autor',
                            controller: _authorEC,
                            validator:
                                Validatorless.required('Autor obrigatório'),
                          ),
                          WidgetTextField(
                            keyboardType: TextInputType.number,
                            label: 'Páginas',
                            controller: _pageNumberEC,
                            validator: Validatorless.required(
                                'Informe o número de páginas'),
                          ),
                          WidgetTextField(
                            keyboardType: TextInputType.text,
                            label: 'Descrição',
                            controller: _descriptionEC,
                            validator:
                                Validatorless.required('Descreva seu pedido'),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                if (_selectedImage == null &&
                                    widget.book?.volumeInfo.imageLinks
                                            .thumbnail ==
                                        null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Por favor, selecione uma imagem'),
                                    ),
                                  );
                                  setState(() {
                                    _isImageSelected = false;
                                  });
                                } else {
                                  await _submitDonation(context);
                                }
                              }
                            },
                            child: const Text('Continuar'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _submitDonation(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String userId = auth.currentUser!.uid;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    setState(() {
      _isLoading = true;
    });

    String? coverImageUrl;

    if (_selectedImage != null) {
      coverImageUrl =
          await requestViewModel.uploadImage(userId, _selectedImage!);
    } else if (widget.book?.volumeInfo.imageLinks.thumbnail != null) {
      coverImageUrl = widget.book!.volumeInfo.imageLinks.thumbnail!;
    }

    try {
      await firestoreServiceRequest.createRequest(
        userUid: userId,
        title: _titleEC.text,
        authors: _authorEC.text,
        bookCover: coverImageUrl,
        category: selectedCategory,
        pageNumber: int.tryParse(_pageNumberEC.text),
        language: selectedLanguage,
        description: _descriptionEC.text,
      );

      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Pedido criado com sucesso!')),
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const DonationRegistrationConfirm()),
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Erro ao criar pedido: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
