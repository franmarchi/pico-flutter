import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:pico/model/helper/Api.dart';
import 'package:pico/telas/telaDashboard/home.dart';
import 'package:pico/telas/telaDashboard/telaRelatorio.dart';
import 'package:pico/telas/telasLogin/telaAtualizarSenha1.dart';
import 'package:pico/telas/telasLogin/telaVerificarEmail.dart';
import 'package:pico/model/entities/Filiais.dart';

class TelaLogin extends StatefulWidget {
  Map<dynamic, dynamic> retorno;
  TelaLogin(this.retorno);

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";
  Api api = Api();

  _verificarLogin() {
    String _email = widget.retorno["email"];
    String _senhaDigitado = _controllerSenha.text;

    Map<String, String> map = {"email": _email, "senha": _senhaDigitado};

    var _camposValidos = _campoValido(_senhaDigitado);
    var bytes = utf8.encode(_senhaDigitado);
    var digest = sha256.convert(bytes);
    _senhaDigitado = digest.toString();
    if (_camposValidos == true) {
      if (widget.retorno["senha"] == _senhaDigitado) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Home(widget.retorno)));
      } else {
        setState(() {
          _mensagemErro = "senha incorreta";
        });
      }
    }
  }

  bool _campoValido(String senha) {
    if (senha.isEmpty) {
      setState(() {
        _mensagemErro = "Preencha o campo senha";
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      var largura = constraint.maxWidth;
      var alturaBarra = AppBar().preferredSize.height;
      return Scaffold(
          backgroundColor: largura > 700 ? Colors.blue : Colors.white,
          appBar: largura > 700
              ? null
              : AppBar(
                  iconTheme: IconThemeData(color: Colors.white),
                  title: Text("Pico"),
                ),
          body: Center(
              child: Padding(
            padding: EdgeInsets.only(top: 50, bottom: 50),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Container(
                  padding: EdgeInsets.all(50),
                  width: largura > 700 ? 500 : double.maxFinite,
                  height: double.maxFinite,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Text(
                            _mensagemErro,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        Text(
                          "${widget.retorno["email"]}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecoration(labelText: "Digite sua Senha"),
                            style: TextStyle(fontSize: 15),
                            controller: _controllerSenha,
                            obscureText: true,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  child: Text(
                                    "voltar",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TelaVerificarEmail()));
                                  },
                                ),
                                ElevatedButton(
                                  child: Text(
                                    "Entrar",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: _verificarLogin,
                                ),
                              ],
                            )),
                      ],
                    ),
                  )),
            ),
          )));
    });
  }
}
