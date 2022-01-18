import 'package:flutter/material.dart';
import 'package:pico/telas/telasLogin/telaVerificarEmail.dart';

/*class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}*/

void main() {
  runApp(MaterialApp(
    home: TelaVerificarEmail(),
    debugShowCheckedModeBanner: false,
  ));
}
