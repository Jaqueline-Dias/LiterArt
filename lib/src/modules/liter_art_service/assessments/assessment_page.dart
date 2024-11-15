/*import 'dart:io';
import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/model/itens.dart';
import 'package:app_liter_art/src/modules/liter_art_service/assessments/assesment_view_model.dart';
import 'package:app_liter_art/src/modules/liter_art_service/assessments/assessment_confirmation_page.dart';
import 'package:app_liter_art/src/modules/liter_art_service/donations/widgets/widget_text_field.dart';
import 'package:app_liter_art/src/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:validatorless/validatorless.dart';

class AssessmentPage extends StatefulWidget {
  const AssessmentPage({super.key, this.book, required this.isFromApi});

  final Item? book;
  final bool isFromApi;

  @override
  State<AssessmentPage> createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  final AssessmentViewModel assesmentViewModel = AssessmentViewModel();
  final _titleEC = TextEditingController();
  final _authorEC = TextEditingController();
  final _categoryEC = TextEditingController();
  final _pageNumberEC = TextEditingController();
  final _pagesReadEC = TextEditingController();
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
  String? selectedCategory;

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
      }
    }
  }

  @override
  void dispose() {
    _titleEC.dispose();
    _authorEC.dispose();
    _categoryEC.dispose();
    _pageNumberEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BottomNavigatorAppBar(),
        title: const Text(
          'Nova avaliação',
          style: AppLiterArtTheme.textInfoAppBar,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 24),
            child: Text(
              '1/2',
              style: AppLiterArtTheme.textInfoAppBar,
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
                    await assesmentViewModel.pickImageFromGallery();
                    setState(() {
                      // Define como válida se a imagem foi selecionada pelo usuário ou veio da API
                      _isImageSelected = assesmentViewModel.selectedImage !=
                              null ||
                          widget.book?.volumeInfo.imageLinks.thumbnail != null;
                    });
                  },
                  child: assesmentViewModel.selectedImage != null
                      ? Image.file(
                          assesmentViewModel.selectedImage!,
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
                                color: AppLiterArtTheme.violetLigth2,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                      validator: (value) => assesmentViewModel.validateDropdown(
                          value, 'Escolha uma categoria'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: WidgetTextField(
                            keyboardType: TextInputType.phone,
                            label: 'Páginas',
                            controller: _pageNumberEC,
                            validator: Validatorless.required(
                                'Informe o número de páginas'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: WidgetTextField(
                            keyboardType: TextInputType.phone,
                            label: 'Páginas lidas',
                            controller: _pagesReadEC,
                            validator: Validatorless.required(
                                'Informe o número de páginas lidas'),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    // Botão continuar
                    ElevatedButton(
                      onPressed: () {
                        final isFormValid = _formKey.currentState!.validate();
                        final isImageValid =
                            assesmentViewModel.selectedImage != null ||
                                widget.book?.volumeInfo.imageLinks.thumbnail !=
                                    null;

                        setState(() {
                          _isImageSelected =
                              isImageValid; // Atualiza o estado para renderizar o erro imediatamente
                        });

                        if (isFormValid && isImageValid) {
                          final pageNumber =
                              int.tryParse(_pageNumberEC.text) ?? 0;
                          final pagesRead =
                              int.tryParse(_pagesReadEC.text) ?? 0;
                          final File? selectedImage =
                              assesmentViewModel.selectedImage;
                          final bool isValidFile = selectedImage != null &&
                              selectedImage.existsSync();

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AssessmentConfirmationPage(
                              title: _titleEC.text,
                              author: _authorEC.text,
                              category: selectedCategory,
                              pageNumber: pageNumber,
                              selectedImage: isValidFile ? selectedImage : null,
                              apiImageUrl:
                                  widget.book?.volumeInfo.imageLinks.thumbnail,
                              pagesRead: pagesRead,
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
}*/

import 'package:app_liter_art/src/model/models.dart';
import 'package:app_liter_art/src/modules/liter_art_service/assessments/assesment_view_model.dart';
import 'package:app_liter_art/src/modules/liter_art_service/assessments/widgets/continue_button.dart';
import 'package:app_liter_art/src/modules/liter_art_service/assessments/widgets/cover_image_picker.dart';
import 'package:app_liter_art/src/modules/liter_art_service/assessments/widgets/form_fields.dart';
import 'package:app_liter_art/src/modules/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AssessmentPage extends StatefulWidget {
  const AssessmentPage({super.key, this.book, required this.isFromApi});

  final Item? book;
  final bool isFromApi;

  @override
  State<AssessmentPage> createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  final AssessmentViewModel viewModel = AssessmentViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.initializeData(widget.isFromApi, widget.book);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Nova avaliação', stepText: '1/2'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              children: [
                CoverImagePicker(viewModel: viewModel, book: widget.book),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormFields(viewModel: viewModel),
                    const SizedBox(height: 20),
                    ContinueButton(viewModel: viewModel, book: widget.book),
                    const SizedBox(height: 32),
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
