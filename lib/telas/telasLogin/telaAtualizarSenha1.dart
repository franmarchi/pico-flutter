import 'package:flutter/material.dart';
import 'package:pico/model/helper/Api.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:pico/telas/telasLogin/telaLogin.dart';
import 'package:pico/telas/telasLogin/telaVerificarEmail.dart';

class TelaAtualizarSenha1 extends StatefulWidget {
  Map<dynamic, dynamic> retorno;
  TelaAtualizarSenha1(this.retorno);

  @override
  _TelaAtualizarSenha1State createState() => _TelaAtualizarSenha1State();
}

class _TelaAtualizarSenha1State extends State<TelaAtualizarSenha1> {
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerConfSenha = TextEditingController();
  String _mensagemErro = "";

  void _atualizarSenha() async {
    Api api = Api();
    String _senha = _controllerSenha.text;
    String _confSenha = _controllerConfSenha.text;
    RegExp _isNumeric = RegExp(r'^-?[0-9]+$');
    bool campoVerificado = true;

    if (_senha.length < 6 || _isNumeric.hasMatch(_senha)) {
      _mensagemErro = "Senha precisa ter no minimo 6 digitos e uma letra";
      campoVerificado = false;
    } else if (_senha != _confSenha) {
      _mensagemErro = "A confirmação da senha está incorreta";
      campoVerificado = false;
    }

    setState(() {
      _mensagemErro;
    });

    var bytes = utf8.encode(_senha);
    var digest = sha256.convert(bytes);
    _senha = digest.toString();

    if (campoVerificado == true) {
      bool sucesso = await api.atualizarSenha(widget.retorno["email"], _senha);

      if (sucesso == true) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => TelaVerificarEmail()));
      } else {
        setState(() {
          _mensagemErro = "Algo deu errado, tente novamente mais tarde";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Pico"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("${widget.retorno["email"]}",
                    style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(_mensagemErro, style: TextStyle(color: Colors.red)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(labelText: "Crie uma Senha"),
                  style: TextStyle(fontSize: 15),
                  controller: _controllerSenha,
                  obscureText: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(labelText: "Confirmar senha"),
                  style: TextStyle(fontSize: 15),
                  controller: _controllerConfSenha,
                  obscureText: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  child: Text(
                    "Atualizar",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(8, 170, 87, 1)),
                  onPressed: _atualizarSenha,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
