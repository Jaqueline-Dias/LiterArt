import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/modules/auth/register/register_view_model.dart';
import 'package:app_liter_art/src/modules/auth/widgets/custom_text_field_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final RegisterViewModel _registerViewModel = RegisterViewModel();
  final _nicknameEC = TextEditingController();
  final _biographyEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  XFile? _arquivoImagem;

  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  Future<XFile?> _capturaFoto() async {
    final ImagePicker picker = ImagePicker();
    XFile? imagem;

    imagem = await picker.pickImage(source: ImageSource.gallery);

    if (imagem != null) {
      setState(() {
        _arquivoImagem = imagem;
      });
    }
    return null;
  }

  @override
  void dispose() {
    _nicknameEC.dispose();
    _biographyEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppLiterArtTheme.violetBackground,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 100,
                    ),
                  ],
                ),
              ),

              //Formulário
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 32,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(65),
                  ),
                ),

                //Campos do formulário
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                        child: Text(
                          'Cadastre-se',
                          style: AppLiterArtTheme.titleAlertDialog,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            //Imagem da foto e decoração do container
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 4,
                                  color: Colors.white,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                  )
                                ],
                                shape: BoxShape.circle,
                                image: _arquivoImagem != null
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                            File(_arquivoImagem!.path)),
                                      )
                                    : const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 0,
                                    color: Colors.white,
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.add_circle),
                                  color: AppLiterArtTheme.violetButton,
                                  onPressed: () {
                                    _capturaFoto();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      //Nome
                      CustomTextFieldConfig(
                        icon: Icons.person,
                        label: 'Nickname',
                        keyboardType: TextInputType.text,
                        controller: _nicknameEC,
                        // validator: nameValidator,
                      ),

                      //Email
                      CustomTextFieldConfig(
                        icon: Icons.edit,
                        label: 'Biografia',
                        keyboardType: TextInputType.emailAddress,
                        controller: _biographyEC,
                        // validator: emailValidator,
                      ),

                      //Email
                      CustomTextFieldConfig(
                        icon: Icons.email,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailEC,
                        // validator: emailValidator,
                      ),

                      //Senha
                      CustomTextFieldConfig(
                        icon: Icons.lock,
                        label: 'Senha',
                        isSecret: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordEC,
                        // validator: passwordValidator,
                      ),

                      const SizedBox(
                        height: 32,
                      ),

                      //Botão de cadastro
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String nickname = _nicknameEC.text;
                            String biography = _biographyEC.text;
                            String email = _emailEC.text;
                            String password = _passwordEC.text;
                            XFile? image = _arquivoImagem;

                            _registerViewModel.signUp(
                              context: context,
                              nickname: nickname,
                              biography: biography,
                              email: email,
                              password: password,
                              image: image,
                            );
                          }
                        },
                        child: const Text('Cadastrar'),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text.rich(
                          TextSpan(
                            text: 'Já tem uma conta? ',
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Fazer login',
                                style: const TextStyle(
                                  color: AppLiterArtTheme.grey, // Cor diferente
                                  fontWeight: FontWeight.bold, // Negrito
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/auth/login');
                                  },
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
