import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pico/model/chart_series/GraficoporAnoSeries.dart';
import 'package:pico/model/helper/Api.dart';
import 'package:pico/model/entities/Filiais.dart';
import 'package:pico/model/entities/RelatorioGerencialGraficoVendasporAno.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';

import 'package:pico/telas/telaDashboard/telaRelatorioGerenciais.dart';

class TelaGraficoVendasPorAno extends StatefulWidget {
  const TelaGraficoVendasPorAno({Key? key}) : super(key: key);

  @override
  _TelaGraficoVendasPorAnoState createState() =>
      _TelaGraficoVendasPorAnoState();
}

class _TelaGraficoVendasPorAnoState extends State<TelaGraficoVendasPorAno> {
  var maskFormatterAno =
      new MaskTextInputFormatter(mask: '####', filter: {"#": RegExp(r'[0-9]')});
  TextEditingController _controllerAno = TextEditingController();
  String _mensagem = "";
  String dropdownValue = "";
  String _ano = "";
  List _relatorio = [];
  List<GraficoporAnoSeries> listDadosGrafico = [];
  Api api = Api();
  List<Filiais> _filiais = [];
  List<String> _nomeFiliais = [];
  String total = "";

  void _exibirFiliais() async {
    List listaTemporaria = await api.buscarFiliais();

    List<Filiais>? filiaisRecuperadas = [];
    List<String>? nomeFiliaisRecuperadas = [];
    nomeFiliaisRecuperadas.add("");
    for (var item in listaTemporaria) {
      item = jsonDecode(item) as Map;
      var result = item.cast<dynamic, dynamic>();
      Filiais filiais = Filiais.fromMap(result);
      filiaisRecuperadas.add(filiais);
      nomeFiliaisRecuperadas.add(filiais.filial);
    }
    setState(() {
      _filiais = filiaisRecuperadas!;
      _nomeFiliais = nomeFiliaisRecuperadas;
    });
    filiaisRecuperadas = null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _exibirFiliais();
  }

  void _exibirRelatorio() async {
    String _ano = _controllerAno.text;

    String filialEscolhida = "";
    if (dropdownValue != "") {
      for (var item in _filiais) {
        if (item.filial == dropdownValue) {
          filialEscolhida = item.codigo;
        }
      }
    }

    List listaTemporaria =
        await api.buscarRelatorioGraficoPorAno(_ano, filialEscolhida);

    List<GraficoporAnoSeries>? relatorioRecuperado = [];
    if (listaTemporaria.length == 0) {
      setState(() {
        _mensagem = "Não há dados para o período selecionado!";
      });
    }

    if (listDadosGrafico.length == 0) {
      setState(() {
        _mensagem = "Não há dados para o período selecionado!";
      });
    }
    for (var item in listaTemporaria) {
      item = jsonDecode(item) as Map;
      var result = item.cast<dynamic, dynamic>();

      RelatorioGerencialGraficoVendasporAno
          relatorioGerencialGraficoVendasporAno =
          RelatorioGerencialGraficoVendasporAno.fromMap(result);

      GraficoporAnoSeries graficoporAnoSeries = GraficoporAnoSeries(
          relatorioGerencialGraficoVendasporAno.mes,
          relatorioGerencialGraficoVendasporAno.total);

      total = relatorioGerencialGraficoVendasporAno.total.toString();

      relatorioRecuperado.add(graficoporAnoSeries);
    }

    setState(() {
      listDadosGrafico = relatorioRecuperado!;
    });

    relatorioRecuperado = null;
  }

  gerarGrafico() {
    List<charts.Series<GraficoporAnoSeries, String>> series = [
      charts.Series(
        id: "vendas",
        data: listDadosGrafico,
        domainFn: (GraficoporAnoSeries series, _) => series.mes,
        measureFn: (GraficoporAnoSeries series, _) => series.total,
        labelAccessorFn: (GraficoporAnoSeries series, _) =>
            'R\$ ${series.total.toString()}',
      )
    ];

    return charts.BarChart(
      series,
      animate: true,
      vertical: false,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      var largura = constraint.maxWidth;
      return Container(
          child: Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                        width: largura > 700 ? 320 : largura * 0.45,
                        height: 100,
                        child: Card(
                            child: Padding(
                          padding: EdgeInsets.all(20),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: "Ano"),
                            style: TextStyle(fontSize: 15),
                            controller: _controllerAno,
                            inputFormatters: [maskFormatterAno],
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        left: 12,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Filiais:  ",
                            style:
                                new TextStyle(fontSize: 15, color: Colors.blue),
                          ),
                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.blue,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: _nomeFiliais
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                          child: Text(
                            "Pesquisar",
                            style: TextStyle(fontSize: 17),
                          ),
                          onPressed: _exibirRelatorio),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    listDadosGrafico.length > 0
                        ? Center(
                            child: Container(
                                height: 400,
                                padding: EdgeInsets.all(20),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: gerarGrafico(),
                                        ),
                                      ],
                                    ),
                                  ),
                                )))
                        : Text(_mensagem)
                  ],
                ),
              )));
    });
  }
}
