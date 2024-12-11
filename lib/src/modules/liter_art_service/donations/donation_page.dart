import 'dart:io';
import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:app_liter_art/src/model/itens.dart';
import 'package:app_liter_art/src/modules/liter_art_service/donations/donation_confirmation_page.dart';
import 'package:app_liter_art/src/modules/liter_art_service/donations/donations_view_model.dart';
import 'package:app_liter_art/src/modules/liter_art_service/donations/widgets/widget_text_field.dart';
import 'package:app_liter_art/src/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:validatorless/validatorless.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key, this.book, required this.isFromApi});

  final Item? book;
  final bool isFromApi;

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final DonationsViewModel donationsViewModel = DonationsViewModel();
  final _titleEC = TextEditingController();
  final _authorEC = TextEditingController();
  final _categoryEC = TextEditingController();
  final _pageNumberEC = TextEditingController();
  final _languageEC = TextEditingController();
  final _synopsisEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isImageSelected = true;

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
  String? selectedLanguage;
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    if (widget.isFromApi == true && widget.book != null) {
      _titleEC.text = widget.book?.volumeInfo.title ?? '';
      _authorEC.text = widget.book?.volumeInfo.authors.join(", ") ?? '';
      _pageNumberEC.text = widget.book?.volumeInfo.pageCount.toString() ?? '';
      _synopsisEC.text = widget.book?.volumeInfo.description ?? '';

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
    _categoryEC.dispose();
    _pageNumberEC.dispose();
    _languageEC.dispose();
    _synopsisEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BottomNavigatorAppBar(),
        title: const Text(
          'Nova doação',
          style: LAAppTheme.textInfoAppBar,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 24),
            child: Text(
              '1/2',
              style: LAAppTheme.textInfoAppBar,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Verificação de imagem: selecionada ou da API
                GestureDetector(
                  onTap: () async {
                    await donationsViewModel.pickImageFromGallery();
                    setState(() {
                      // Define como válida se a imagem foi selecionada pelo usuário ou veio da API
                      _isImageSelected = donationsViewModel.selectedImage !=
                              null ||
                          widget.book?.volumeInfo.imageLinks.thumbnail != null;
                    });
                  },
                  child: donationsViewModel.selectedImage != null
                      ? Image.file(
                          donationsViewModel.selectedImage!,
                          fit: BoxFit.cover,
                          height: 180,
                        )
                      : widget.book?.volumeInfo.imageLinks.thumbnail != null
                          ? Image.network(
                              widget.book!.volumeInfo.imageLinks.thumbnail!,
                              fit: BoxFit.cover,
                              height: 180,
                            )
                          : Container(
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
                                      _isImageSelected
                                          ? LAColors.buttonPrimary
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
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                ),
                const SizedBox(height: 16),

                // Outros campos do formulário
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
                      validator: (value) => donationsViewModel.validateDropdown(
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
                      validator: (value) => donationsViewModel.validateDropdown(
                          value, 'Escolha um idioma'),
                    ),
                    WidgetTextField(
                      keyboardType: TextInputType.text,
                      label: 'Título',
                      controller: _titleEC,
                      validator: Validatorless.required('Título obrigatório'),
                    ),
                    WidgetTextField(
                      keyboardType: TextInputType.text,
                      label: 'Autor',
                      controller: _authorEC,
                      validator: Validatorless.required('Autor obrigatório'),
                    ),
                    WidgetTextField(
                      keyboardType: TextInputType.phone,
                      label: 'Páginas',
                      controller: _pageNumberEC,
                      validator:
                          Validatorless.required('Informe o número de páginas'),
                    ),
                    WidgetTextField(
                      keyboardType: TextInputType.text,
                      label: 'Sinopse',
                      controller: _synopsisEC,
                      maxLines: 3,
                      validator: Validatorless.required('Sinopse obrigatória'),
                    ),
                    const SizedBox(height: 20),
                    // Botão continuar
                    ElevatedButton(
                      onPressed: () {
                        final isFormValid = _formKey.currentState!.validate();
                        final isImageValid =
                            donationsViewModel.selectedImage != null ||
                                widget.book?.volumeInfo.imageLinks.thumbnail !=
                                    null;

                        setState(() {
                          _isImageSelected =
                              isImageValid; // Atualiza o estado para renderizar o erro imediatamente
                        });

                        if (isFormValid && isImageValid) {
                          final File? selectedImage =
                              donationsViewModel.selectedImage;
                          final bool isValidFile = selectedImage != null &&
                              selectedImage.existsSync();

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DonationConfirmationPage(
                              title: _titleEC.text,
                              author: _authorEC.text,
                              category: selectedCategory,
                              pageNumber: _pageNumberEC.text,
                              language: selectedLanguage,
                              synopsis: _synopsisEC.text,
                              selectedImage: isValidFile ? selectedImage : null,
                              apiImageUrl:
                                  widget.book?.volumeInfo.imageLinks.thumbnail,
                            ),
                          ));
                        } else if (!isImageValid) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('A imagem é obrigatória'),
                            ),
                          );
                        }
                      },
                      child: const Text('Continuar'),
                    ),
                    const SizedBox(
                      height: 32,
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
}
