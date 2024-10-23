import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel {
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print('Erro ao realizar login');
      print('Erro ao realizar login');
    }
    return null;
  }
}
