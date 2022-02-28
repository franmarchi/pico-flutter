import 'package:flutter/material.dart';
import 'package:pico/model/helper/Api.dart';
import 'package:pico/model/chart_series/GraficoporFilialSeries.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pico/model/entities/RelatorioGerencialGraficoVendasporFilial.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';

class TelaGraficoVendasPorFilial extends StatefulWidget {
  const TelaGraficoVendasPorFilial({Key? key}) : super(key: key);

  @override
  _TelaGraficoVendasPorFilialState createState() =>
      _TelaGraficoVendasPorFilialState();
}

class _TelaGraficoVendasPorFilialState
    extends State<TelaGraficoVendasPorFilial> {
  TextEditingController _controllerDataInic = TextEditingController();
  TextEditingController _controllerDataFinal = TextEditingController();

  var maskFormatterDataInic = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  var maskFormatterDataFinal = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  Api api = Api();
  List<GraficoporFilialSeries> listDadosGrafico = [];
  String _mensagem = "";

  _formatarData(String dataString) {
    List dataFormatada = dataString.split("/");
    String ano = dataFormatada[2];
    String mes = dataFormatada[1];
    String dia = dataFormatada[0];

    String _data = ano + "-" + mes + "-" + dia;

    return _data;
  }

  void _exibirRelatorio() async {
    String _dataInicial = _formatarData(_controllerDataInic.text);
    String _dataFinal = _formatarData(_controllerDataFinal.text);

    List listaTemporaria =
        await api.buscarRelatorioGraficoPorFilial(_dataInicial, _dataFinal);

    List<GraficoporFilialSeries>? relatorioRecuperado = [];
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

      RelatorioGerencialGraficoVendasporFilial
          relatorioGerencialGraficoVendasporFilial =
          RelatorioGerencialGraficoVendasporFilial.fromMap(result);

      GraficoporFilialSeries graficoporFilialSeries = GraficoporFilialSeries(
          relatorioGerencialGraficoVendasporFilial.nome,
          relatorioGerencialGraficoVendasporFilial.total);

      relatorioRecuperado.add(graficoporFilialSeries);
    }

    setState(() {
      listDadosGrafico = relatorioRecuperado!;
    });

    relatorioRecuperado = null;
  }

  gerarGrafico() {
    List<charts.Series<GraficoporFilialSeries, String>> series = [
      charts.Series(
        id: "Filial",
        data: listDadosGrafico,
        domainFn: (GraficoporFilialSeries series, _) => series.nome,
        measureFn: (GraficoporFilialSeries series, _) => series.total,
        labelAccessorFn: (GraficoporFilialSeries series, _) =>
            'R\$ - ${series.total.toString()}',
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: largura > 700 ? 320 : largura * 0.45,
                            height: 100,
                            child: Card(
                                child: Padding(
                              padding: EdgeInsets.all(20),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(labelText: "Data inicial"),
                                style: TextStyle(fontSize: 15),
                                controller: _controllerDataInic,
                                inputFormatters: [maskFormatterDataInic],
                              ),
                            )),
                          ),
                          SizedBox(
                            width: largura > 700 ? 15 : 5,
                          ),
                          Container(
                            width: largura > 700 ? 320 : largura * 0.45,
                            height: 100,
                            child: Card(
                                child: Padding(
                              padding: EdgeInsets.all(20),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(labelText: "Data Final"),
                                style: TextStyle(fontSize: 15),
                                controller: _controllerDataFinal,
                                inputFormatters: [maskFormatterDataFinal],
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
