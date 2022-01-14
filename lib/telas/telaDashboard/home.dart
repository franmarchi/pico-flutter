import 'package:flutter/material.dart';
import 'package:pico/telas/telaDashboard/appbarMobile.dart';
import 'package:pico/telas/telaDashboard/telaRelatorio.dart';
import 'package:pico/telas/telaDashboard/telaRelatorioABCProdutos.dart';
import 'package:pico/telas/telaDashboard/telaRelatorioABCVendedor.dart';
import 'package:pico/telas/telaDashboard/telaRelatorioGerenciais.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  /*Map<dynamic, dynamic> retorno;
  Home(this.retorno);*/

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _telaAtual = 0;
  List _tela = [
    TelaRelatorio(),
    TelaRelatorioABCProdutos(),
    TelaRelatorioABCVendedor()
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      var largura = constraint.maxWidth;
      var alturaBarra = AppBar().preferredSize.height;

      return Scaffold(
        appBar: largura < 700
            ? PreferredSize(
                child: AppBarMobile(),
                preferredSize: Size(largura, alturaBarra))
            : null,
        drawer: largura < 700
            ? Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Seja Bem-vindo(a)",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white)),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  /*"${widget.retorno["nome"]}"*/ "",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Text(/*"${widget.retorno["email"]}"*/ "",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text("Relatorio Filiais"),
                      onTap: () {
                        setState(() {
                          _telaAtual = 0;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text("Relatorio G. curva ABC Produtos"),
                      onTap: () {
                        setState(() {
                          _telaAtual = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text("Relatorio G. curva ABC Venda"),
                      onTap: () {
                        setState(() {
                          _telaAtual = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text("Grupo produtos"),
                      onTap: () {
                        setState(() {
                          _telaAtual = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text("Venda dia"),
                      onTap: () {
                        setState(() {
                          _telaAtual = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              )
            : null,
        body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.lightBlue[800],
                  height: double.maxFinite,
                  width: largura > 700 ? 250 : null,
                  //color: Colors.grey,
                  child: largura > 700
                      ? ListView(
                          children: [
                            ListTile(),
                            ListTile(
                              title: Text(
                                "Relatorio Filiais",
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                setState(() {
                                  _telaAtual = 0;
                                });
                              },
                            ),
                            ListTile(
                              title: Text(
                                "Relatorio G. curva ABC Produtos",
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                setState(() {
                                  _telaAtual = 1;
                                });
                              },
                            ),
                            ListTile(
                              title: Text(
                                "Relatorio G. curva ABC Venda",
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                setState(() {
                                  _telaAtual = 2;
                                });
                              },
                            ),
                            ListTile(
                              title: Text(
                                "Grupo produtos",
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                setState(() {
                                  _telaAtual = 0;
                                });
                              },
                            ),
                            ListTile(
                              title: Text(
                                "Venda dia",
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                setState(() {
                                  _telaAtual = 0;
                                });
                              },
                            ),
                          ],
                        )
                      : null,
                ),
                Expanded(child: _tela[_telaAtual]),
              ],
            )),
      );
    });
  }
}
