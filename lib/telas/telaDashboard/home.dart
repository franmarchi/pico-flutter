import 'package:flutter/material.dart';
import 'package:pico/model/helper/MensagensLegais.dart';
import 'package:pico/telas/telaDashboard/TelaRelatorioResumoVendas.dart';
import 'package:pico/telas/telaDashboard/appbarMobile.dart';
import 'package:pico/telas/telaDashboard/telaGraficoVendasPorAno.dart';
import 'package:pico/telas/telaDashboard/telaGraficoVendasPorFilial.dart';
import 'package:pico/telas/telaDashboard/telaRelatorio.dart';
import 'package:pico/telas/telaDashboard/telaRelatorioABCProdutos.dart';
import 'package:pico/telas/telaDashboard/telaRelatorioABCVendedor.dart';
import 'package:pico/telas/telaDashboard/telaVendasDia.dart';
import 'package:pico/telas/telasLogin/telaVerificarEmail.dart';

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
    TelaRelatorioABCVendedor(),
    TelaVendasDia(),
    TelaRelatorioResumoVendas(),
    TelaGraficoVendasPorAno(),
    TelaGraficoVendasPorFilial()
  ];

  MensagensLegais mensagensLegais = MensagensLegais();

  exibirMensagemTermosdeUso() {
    mensagensLegais.exibirTermosdeUso(context);
  }

  exibirMensagemPoliticaPrivacidade() {
    mensagensLegais.exibirPoliticaPrivacidade(context);
  }

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
                      title: Text("Fechamento de vendas"),
                      onTap: () {
                        setState(() {
                          _telaAtual = 0;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ExpansionTile(
                      title: Text("Relatórios gerenciais"),
                      children: [
                        ListTile(
                          title: Text("Curva ABC - Produtos"),
                          onTap: () {
                            setState(() {
                              _telaAtual = 1;
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text("Curva ABC - Filial/Vendedores"),
                          onTap: () {
                            setState(() {
                              _telaAtual = 2;
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text("Vendas por dia"),
                          onTap: () {
                            setState(() {
                              _telaAtual = 3;
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text("Resumo de vendas"),
                          onTap: () {
                            setState(() {
                              _telaAtual = 4;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text("Grafico - Vendas por ano"),
                      onTap: () {
                        setState(() {
                          _telaAtual = 5;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text("Grafico - Vendas por Filial"),
                      onTap: () {
                        setState(() {
                          _telaAtual = 6;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(),
                    ListTile(
                      leading: Icon(
                        Icons.info_outline,
                      ),
                      title: Text("Termos de uso",
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        exibirMensagemTermosdeUso();
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.info_outline,
                      ),
                      title: Text("Politica de privacidade",
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        exibirMensagemPoliticaPrivacidade();
                      },
                    ),
                    ListTile(
                        leading: Icon(Icons.logout),
                        title: Text("Desconectar"),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    TelaVerificarEmail(),
                              ),
                              (route) => false);
                        }),
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
                            Container(
                              color: _telaAtual == 0 ? Colors.white : null,
                              child: ListTile(
                                title: Text(
                                  "Fechamento de Vendas",
                                  style: TextStyle(
                                      color: _telaAtual == 0
                                          ? Colors.blue
                                          : Colors.white),
                                ),
                                onTap: () {
                                  setState(() {
                                    _telaAtual = 0;
                                  });
                                },
                              ),
                            ),
                            ExpansionTile(
                              title: Text("Relatório Gerencial",
                                  style: TextStyle(color: Colors.white)),
                              children: [
                                Container(
                                  color: _telaAtual == 1 ? Colors.white : null,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: ListTile(
                                      title: Text(
                                        "Curva ABC - Produtos",
                                        style: TextStyle(
                                            color: _telaAtual == 1
                                                ? Colors.blue
                                                : Colors.white),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _telaAtual = 1;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  color: _telaAtual == 2 ? Colors.white : null,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: ListTile(
                                      title: Text(
                                        "Curva ABC - Vendedores/Filiais",
                                        style: TextStyle(
                                            color: _telaAtual == 2
                                                ? Colors.blue
                                                : Colors.white),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _telaAtual = 2;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  color: _telaAtual == 3 ? Colors.white : null,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: ListTile(
                                      title: Text(
                                        "Vendas por dia",
                                        style: TextStyle(
                                            color: _telaAtual == 3
                                                ? Colors.blue
                                                : Colors.white),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _telaAtual = 3;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  color: _telaAtual == 4 ? Colors.white : null,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: ListTile(
                                      title: Text(
                                        "Resumo de Vendas",
                                        style: TextStyle(
                                            color: _telaAtual == 4
                                                ? Colors.blue
                                                : Colors.white),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _telaAtual = 4;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  color: _telaAtual == 5 ? Colors.white : null,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: ListTile(
                                      title: Text("Gráfico - Vendas por ano",
                                          style: TextStyle(
                                              color: _telaAtual == 5
                                                  ? Colors.blue
                                                  : Colors.white)),
                                      onTap: () {
                                        setState(() {
                                          _telaAtual = 5;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  color: _telaAtual == 6 ? Colors.white : null,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: ListTile(
                                      title: Text("Gráfico - Vendas por Filial",
                                          style: TextStyle(
                                              color: _telaAtual == 6
                                                  ? Colors.blue
                                                  : Colors.white)),
                                      onTap: () {
                                        setState(() {
                                          _telaAtual = 6;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ListTile(),
                            ListTile(
                              leading: Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                              title: Text("Termos de uso",
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                exibirMensagemTermosdeUso();
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                              title: Text("Politica de privacidade",
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                exibirMensagemPoliticaPrivacidade();
                              },
                            ),
                            ListTile(
                                leading: Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                                title: Text("Desconectar",
                                    style: TextStyle(color: Colors.white)),
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            TelaVerificarEmail(),
                                      ),
                                      (route) => false);
                                }),
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
