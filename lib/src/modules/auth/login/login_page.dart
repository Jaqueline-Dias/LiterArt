import 'package:app_liter_art/src/common/styles/styles.dart';
import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:app_liter_art/src/modules/auth/login/login_view_model.dart';
import 'package:app_liter_art/src/modules/auth/widgets/custom_text_field_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final controller = Injector.get<LoginViewModel>();

  void _sigIn() async {
    String email = _emailEC.text;
    String password = _passwordEC.text;

    User? user = await controller.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print('Login realizado com sucesso');
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      print('Erro ao realizar login');
    }
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: LAColors.violetBackground,
      body: SingleChildScrollView(
        child: SizedBox(
          height: sizeOf.height,
          width: sizeOf.width,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo/logo.png',
                          height: 100,
                        ),
                      ],
                    ),
                  ),

//Formulário
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 40,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(65),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Center(
                              child: Text(
                            'Login',
                            style: LAStyles.titleAlertDialog,
                          )),
                          const SizedBox(
                            height: 16,
                          ),
//Email - campo com referência do widget custom_text_field na pasta config
                          CustomTextFieldConfig(
                            icon: Icons.email,
                            label: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('Email obrigatório'),
                              Validatorless.email('Email inválido'),
                            ]),
                          ),

//Senha
                          CustomTextFieldConfig(
                            icon: Icons.lock,
                            label: 'Senha',
                            keyboardType: TextInputType.visiblePassword,
                            isSecret: true,
                            controller: _passwordEC,
                            validator:
                                Validatorless.required('Senha obrigatória'),
                          ),

//Botão para entrar na aplicação
                          const SizedBox(
                            height: 32,
                          ),
                          SizedBox(
                            width: sizeOf.width * .8,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                final valid =
                                    _formKey.currentState?.validate() ?? false;

                                if (valid) {
                                  _sigIn();
                                }
                              },
                              child: const Text('ENTRAR'),
                            ),
                          ),

//Botão esqueceu a senha
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Esqueceu sua senha?',
                                style: TextStyle(
                                    //color: CustomColors.customContrastColor,
                                    ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 24,
                          ),
//Divisor
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.withAlpha(90),
                                    thickness: 2,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Text('Ou'),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.withAlpha(90),
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),

//Botão de cadastro
                          const SizedBox(
                            height: 32,
                          ),
                          SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/auth/register');
                              },
                              child: const Text(
                                'Quero me cadastrar',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: LAColors.textPrimary,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
