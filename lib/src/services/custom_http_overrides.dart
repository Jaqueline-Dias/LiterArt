import 'dart:io';

//Permite ignorar erros de certificados SSL inválidos em requisições HTTP feitas com o HttpClient do Dart.
class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
