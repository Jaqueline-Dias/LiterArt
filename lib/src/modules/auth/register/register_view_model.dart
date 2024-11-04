import 'package:app_liter_art/src/model/model_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Função para verificar se o nickname já existe
  Future<bool> isNicknameUnique(String nickname) async {
    final querySnapshot = await _db
        .collection('users')
        .where('nickname', isEqualTo: nickname)
        .get();

    // Se a lista de documentos retornados tiver pelo menos um item, o nickname já existe
    return querySnapshot.docs.isEmpty;
  }

  // Método para registrar o usuário
  Future<User?> signUp({
    required String nickname,
    required BuildContext context,
    String? biography,
    int? points = 50,
    required String email,
    required String password,
    XFile? image,
  }) async {
    try {
      // Verifique se o nickname é único antes de prosseguir com o cadastro
      bool isUnique = await isNicknameUnique(nickname);
      if (!isUnique) {
        // Exibe uma mensagem de erro e cancela o cadastro
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nickname já está em uso!")),
        );
        return null; // Encerra o método se o nickname já existir
      }

      // Criação do usuário no Firebase Authentication
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Atualiza o perfil do usuário com o nome
      await result.user!.updateDisplayName(nickname);

      // Armazenamento da imagem do usuário no Firebase Storage (opcional)
      FirebaseStorage storage = FirebaseStorage.instance;

      Reference pastaRaiz = storage.ref();
      Reference arquivo = pastaRaiz
          .child('profile')
          .child(DateTime.now().millisecondsSinceEpoch.toString());

      // Envio do arquivo para o serviço de armazenamento
      await arquivo.putFile(File(image!.path));

      // Obtenha a URL do arquivo específico
      var fotoUrl = await arquivo.getDownloadURL();
      await result.user!.updatePhotoURL(fotoUrl);

      await Future.delayed(const Duration(seconds: 2));

      // Adiciona esse usuário no firestore
      ModelUser userModel = ModelUser(
        userUid: result.user!.uid,
        nickname: nickname,
        biography: biography,
        email: email,
        profilePicture: fotoUrl,
        points: points,
        privacy: true,
      );

      await _db
          .collection('users')
          .doc(result.user!.uid)
          .set(userModel.toMap());

      // Redireciona o usuário para a tela inicial após o cadastro bem-sucedido
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }

      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        print('Email já em uso!');
      } else if (e.code == "weak-password") {
        print('Escolha uma senha mais complexa!');
      }
    } catch (e) {
      print('Não foi possível realizar o cadastro.');
    }
    return null;
  }
}
