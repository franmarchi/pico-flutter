import 'package:flutter/material.dart';
import 'package:pico/model/helper/Api.dart';
import 'dart:math';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pico/telas/telasLogin/telaAtualizarSenha1.dart';
import 'package:pico/telas/telasLogin/telaVerificarEmail.dart';

class TelaAtualizarSenha2 extends StatefulWidget {
  //const TelaAtualizarSenha2({Key? key}) : super(key: key);

  String email;
  TelaAtualizarSenha2(this.email);
  @override
  _TelaAtualizarSenha2State createState() => _TelaAtualizarSenha2State();
}

class _TelaAtualizarSenha2State extends State<TelaAtualizarSenha2> {
  TextEditingController _controllerCod = TextEditingController();
  String _mensagemErro = "";
  String codigo = "aaaa";
  Api api = Api();

  _gerarCodigoAleatorio() {
    var codigoEnviado1 = Random().nextInt(9).toString();
    var codigoEnviado2 = Random().nextInt(9).toString();
    var codigoEnviado3 = Random().nextInt(9).toString();
    var codigoEnviado4 = Random().nextInt(9).toString();
    var codigoEnviado =
        codigoEnviado1 + codigoEnviado2 + codigoEnviado3 + codigoEnviado4;
    codigo = codigoEnviado.toString();
    return codigo;
  }

  void _sendEmail() async {
    String email = widget.email;
    String cod = _gerarCodigoAleatorio();
    api.enviarEmail(email, codigo);
  }

  _verificarCodigos() {
    String codigoDigitado = _controllerCod.text;
    if (codigo == codigoDigitado) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  TelaAtualizarSenha1({"email": "${widget.email}"})));
    } else {
      setState(() {
        _mensagemErro = "Codigo Incorreto";
      });
    }
  }

  var maskFormatter =
      new MaskTextInputFormatter(mask: '####', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sendEmail();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      var largura = constraint.maxWidth;
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Redefinir Senha",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Digite o código que enviamos para o seu email",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(_mensagemErro,
                            style: TextStyle(color: Colors.red)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(labelText: "Digite o código"),
                          style: TextStyle(fontSize: 15),
                          controller: _controllerCod,
                          maxLength: 4,
                          inputFormatters: [maskFormatter],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                child: Text(
                                  "Voltar",
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
                                  "Confirmar",
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: _verificarCodigos,
                              ),
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 35),
                        child: GestureDetector(
                            onTap: _sendEmail,
                            child: Text("Não Recebi o código de confirmação",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue))),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
