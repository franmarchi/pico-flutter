import 'package:flutter/material.dart';
import 'package:pico/telas/telaDashboard/home.dart';
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
    //home: Home(),
    home: TelaVerificarEmail(),
    debugShowCheckedModeBanner: false,
  ));
}
