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

  // Método para registrar o usuário
  Future<User?> signUp({
    required String nickname,
    required BuildContext context,
    String? biography,
    required String email,
    required String password,
    XFile? image,
  }) async {
    try {
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
      );

      await _db
          .collection('users')
          .doc(result.user!.uid)
          .set(userModel.toMap());
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        //Email já em uso!
      } else if (e.code == "weak-password") {
        //Escolha uma senha mais complexa!
        print('Escolha uma senha mais complexa!');
      }
    } catch (e) {
      //Não foi possível realizar o cadastro.
      print('Não foi possível realizar o cadastro.');
    } finally {
      // isLoading.value = false;

      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(
            '/home'); // Só usa o context se ainda estiver montado
      }
      print('Cadastro realizado.');
    }
    return null;
  }
}
