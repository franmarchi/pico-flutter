import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:pico/telas/telaDashboard/telaRelatorio.dart';
import 'package:pico/telas/telasLogin/telaVerificarEmail.dart';

void main() {
  runApp(MaterialApp(
    home: TelaVerificarEmail(),
    debugShowCheckedModeBanner: false,
  ));
}
