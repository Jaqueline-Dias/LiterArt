import 'dart:io';
import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:app_liter_art/src/modules/auth/widgets/custom_text_field_config.dart';
import 'package:app_liter_art/src/modules/profile/user/user_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../user/widgets/modal_settings.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  XFile? _arquivoImagem;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Controladores de texto para capturar os dados dos campos de texto
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController biographyController = TextEditingController();

  // Função para atualizar os dados do usuário no Firebase
  Future<void> updateUserData() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        String? imageUrl;

        if (_arquivoImagem != null) {
          final storageRef = FirebaseStorage.instance.ref();
          final profilePicRef =
              storageRef.child('profile').child('${user.uid}.jpg');

          await profilePicRef.putFile(File(_arquivoImagem!.path));
          imageUrl = await profilePicRef.getDownloadURL();
        }

        await firestore.collection('users').doc(user.uid).update({
          if (imageUrl != null) 'profilePicture': imageUrl,
          'nickname': nicknameController.text.trim(),
          'email': emailController.text.trim(),
          'biography': biographyController.text.trim(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Atualizado com sucesso!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao atualizar dados')),
      );
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(user.uid).get();
      return snapshot.data() as Map<String, dynamic>?;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserProfilePage()),
          ),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: LAColors.buttonPrimary,
            size: 32,
          ),
        ),
        title: const Text('Editar dados pessoais'),
        actions: const [LAModalSettings()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<Map<String, dynamic>?>(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 42, left: 24, bottom: 8),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 42, left: 24, bottom: 8),
                    child: Text('Erro ao carregar dados do usuário.'),
                  );
                }
                final userData = snapshot.data!;
                final nickname = userData['nickname'] ?? 'Usuário';
                final profilePicture = userData['profilePicture'] ??
                    'https://via.placeholder.com/150';
                final biography = userData['biography'] ?? '';
                final email = userData['email'] ?? '';

                // Atualiza os controladores com os dados atuais
                nicknameController.text = nickname;
                emailController.text = email;
                biographyController.text = biography;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pickImage();
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: _arquivoImagem != null
                                    ? FileImage(File(_arquivoImagem!.path))
                                    : NetworkImage(profilePicture),
                              ),
                              const SizedBox(height: 16),
                              const Text('Escolher foto'),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 8, left: 16, right: 16),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: LAColors.accent, // Cor da sombra
                                offset: Offset(0, 4), // Deslocamento da sombra
                                blurRadius:
                                    5, // O quão borrada a sombra vai ser
                                spreadRadius:
                                    0, // O quanto a sombra vai se espalhar
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              const Text('Minhas informações'),
                              const SizedBox(
                                height: 24,
                              ),
                              CustomTextFieldConfig(
                                icon: Icons.person_2_rounded,
                                label: 'Nickname de usuário',
                                controller: nicknameController,
                              ),
                              const SizedBox(height: 16),
                              CustomTextFieldConfig(
                                icon: Icons.email,
                                label: 'Endereço de email',
                                controller: emailController,
                              ),
                              const SizedBox(height: 16),
                              CustomTextFieldConfig(
                                icon: Icons.edit,
                                label: 'Biografia',
                                controller: biographyController,
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Excluir minha conta',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF9BA9C0),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () async {
                            await updateUserData();
                            setState(() {});
                          },
                          child: const Text('Salvar alterações'),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(color: LAColors.softGrey),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadProfilePicture() async {
    if (_arquivoImagem == null) return;

    try {
      // Pegando o ID do usuário atual
      User? user = auth.currentUser;
      if (user != null) {
        // Criando referência para o Firebase Storage
        final storageRef = FirebaseStorage.instance.ref();
        final profilePicRef =
            storageRef.child('profile_pictures').child('${user.uid}.jpg');

        // Fazendo upload da imagem
        await profilePicRef.putFile(File(_arquivoImagem!.path));

        // Obtendo a URL de download da imagem
        String imageUrl = await profilePicRef.getDownloadURL();

        // Atualizando a URL da imagem no Firestore
        await firestore.collection('users').doc(user.uid).update({
          'profilePicture': imageUrl,
        });

        // Mostrar mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Imagem de perfil atualizada com sucesso!')),
        );
      }
    } catch (e) {
      // Caso ocorra um erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao atualizar imagem de perfil')),
      );
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Escolher a imagem da galeria
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _arquivoImagem = pickedFile; // Armazenando a imagem escolhida
      });
    }
  }
}
