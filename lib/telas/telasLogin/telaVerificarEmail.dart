import 'package:flutter/material.dart';
import 'package:pico/model/helper/Api.dart';
import 'package:pico/telas/telasLogin/telaLogin.dart';
import 'package:pico/telas/telasLogin/telaAtualizarSenha1.dart';

class TelaVerificarEmail extends StatefulWidget {
  const TelaVerificarEmail({Key? key}) : super(key: key);

  @override
  _TelaVerificarEmailState createState() => _TelaVerificarEmailState();
}

class _TelaVerificarEmailState extends State<TelaVerificarEmail> {
  TextEditingController _controllerEmail = TextEditingController();
  String _mensagemErro = "";
  Api api = Api();

  bool _campoValido(String email) {
    if (email.isEmpty) {
      setState(() {
        _mensagemErro = "Preencha o Campo: Digite o seu Email";
      });
      return false;
    }
    if (email.isNotEmpty && (!email.contains("@") || email.length < 5)) {
      setState(() {
        _mensagemErro = "Este email parece está errado";
      });
      return false;
    }
    return true;
  }

  _verificarLogin() async {
    setState(() {
      _mensagemErro = "Carregando ...";
    });
    String _email = _controllerEmail.text;
    var _camposValidos = _campoValido(_email);
    if (_camposValidos == true) {
      Map<dynamic, dynamic> retorno = await api.verificarUsuario(_email);
      if (retorno["encontrouEmail"] == true &&
          retorno["encontrouSenha"] == true) {
        print("primeiro if");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => TelaLogin(retorno)));
      } else if (retorno["encontrouEmail"] == true &&
          retorno["encontrouSenha"] == false) {
        print("primeiro if");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => TelaAtualizarSenha1(retorno)));
      } else if (retorno["encontrouEmail"] == false &&
          retorno["encontrouSenha"] == false) {
        _exibirMensagemEmailNaoCadastrado();
      }
    }
    setState(() {
      _mensagemErro = "";
    });
  }

  _exibirMensagemEmailNaoCadastrado() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Esse email não está cadastrado",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Fechar")),
            ],
          );
        });
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
                child: Container(
                  padding: EdgeInsets.all(50),
                  width: largura > 700 ? 500 : double.maxFinite,
                  height: double.maxFinite,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 70,
                        ),
                        Center(
                          child: Image.asset("imagens/logo.jpeg"),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          _mensagemErro,
                          style: TextStyle(color: Colors.red),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecoration(labelText: "Digite seu Email"),
                            style: TextStyle(fontSize: 15),
                            controller: _controllerEmail,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: ElevatedButton(
                            child: Text(
                              "Entrar",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: _verificarLogin,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
