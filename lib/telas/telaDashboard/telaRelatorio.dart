import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pico/model/entities/Filiais.dart';
import 'package:pico/model/entities/ItensBonificados.dart';
import 'package:pico/model/entities/ItensVendidoVendedor.dart';
import 'package:pico/model/entities/Relatorio.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:pico/model/entities/RelatorioVendasCanceladas.dart';
import 'package:pico/model/entities/RelatorioVendasCredito.dart';
import 'package:pico/model/entities/RelatorioVendasDetalhadas.dart';
import 'package:pico/model/helper/Api.dart';
import 'package:pico/model/widgetsAux/tabelas.dart';

class TelaRelatorio extends StatefulWidget {
  const TelaRelatorio({Key? key}) : super(key: key);

  @override
  _TelaRelatorioState createState() => _TelaRelatorioState();
}

class _TelaRelatorioState extends State<TelaRelatorio> {
  TextEditingController _controllerDataInic = TextEditingController();
  TextEditingController _controllerDataFinal = TextEditingController();
  String dataInicString = "";
  String dataFinalString = "";
  String data1 = "";
  Api api = Api();
  List _relatorio = [];
  String dropdownValue = "";
  double _bruto = 0;
  double _desconto = 0;
  double _total = 0;
  List<Filiais> _filiais = [];
  List<String> _nomeFiliais = [];
  String _mensagem = "";
  Tabelas tabela = Tabelas();
  List<String> _tipoRelatorio = [
    "Vendas Sintetico",
    "Vendas Credito",
    "Vendas Analitico",
    "Vendas Canceladas",
    "Itens Vendidos",
    "Itens Bonificados",
    "Itens Vendidos por Vendedor"
  ];
  String dropdownValue2 = "Vendas Sintetico";
  String urlScriptTabela = "";

  var maskFormatterDataInic = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  var maskFormatterDataFinal = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  void _exibirRelatorio() async {
    String _dataInicial = _formatarData(_controllerDataInic.text);
    String _dataFinal = _formatarData(_controllerDataFinal.text);
    dataInicString = _controllerDataInic.text;
    dataFinalString = _controllerDataFinal.text;
    String filialEscolhida = "";
    if (dropdownValue != "") {
      for (var item in _filiais) {
        if (item.filial == dropdownValue) {
          filialEscolhida = item.codigo;
        }
      }
    }

    urlScriptTabela = dropdownValue2;
    String urlScript = dropdownValue2.replaceAll(" ", "");
    urlScript = "Relatorio" + urlScript + "Script.php";

    List listaTemporaria = await api.buscarRelatorio(
        _dataInicial, _dataFinal, filialEscolhida, urlScript);

    List? relatorioRecuperado = [];

    if (listaTemporaria.length == 0) {
      setState(() {
        _mensagem = "Não há dados para o período selecionado!";
      });
    }
    _bruto = 0;
    _desconto = 0;
    _total = 0;
    for (var item in listaTemporaria) {
      item = jsonDecode(item) as Map;
      var result = item.cast<dynamic, dynamic>();
      if (dropdownValue2 == "Itens Bonificados" ||
          dropdownValue2 == "Itens Vendidos") {
        ItensBonificados itensBonificados = ItensBonificados.fromMap(result);
        _desconto = _desconto + itensBonificados.quantidade;
        _total = _total + itensBonificados.total;
        relatorioRecuperado.add(itensBonificados);
      } else if (dropdownValue2 == "Itens Vendidos por Vendedor") {
        ItensVendidoVendedor itensVendidoVendedor =
            ItensVendidoVendedor.fromMap(result);
        _desconto = _desconto + itensVendidoVendedor.quantidade;
        _total = _total + itensVendidoVendedor.total;
        relatorioRecuperado.add(itensVendidoVendedor);
      } else if (dropdownValue2 == "Vendas Canceladas") {
        RelatorioVendasCanceladas relatorioVendasCanceladas =
            RelatorioVendasCanceladas.fromMap(result);
        _bruto = _bruto + relatorioVendasCanceladas.subtotal;
        _desconto = _desconto + relatorioVendasCanceladas.desconto;
        _total = _total + relatorioVendasCanceladas.total;
        relatorioRecuperado.add(relatorioVendasCanceladas);
      } else if (dropdownValue2 == "Vendas Credito") {
        RelatorioVendasCredito relatorioVendasCredito =
            RelatorioVendasCredito.fromMap(result);
        _bruto = _bruto + relatorioVendasCredito.bruto;
        _desconto = _desconto + relatorioVendasCredito.desconto;
        _total = _total + relatorioVendasCredito.total;
        relatorioRecuperado.add(relatorioVendasCredito);
      } else if (dropdownValue2 == "Vendas Analitico") {
        RelatorioVendasDetalhadas relatorioVendasDetalhadas =
            RelatorioVendasDetalhadas.fromMap(result);
        _bruto = _bruto + relatorioVendasDetalhadas.subtotal;
        _desconto = _desconto + relatorioVendasDetalhadas.desconto;
        _total = _total + relatorioVendasDetalhadas.total;
        relatorioRecuperado.add(relatorioVendasDetalhadas);
      } else if (dropdownValue2 == "Vendas Sintetico") {
        Relatorio relatorio = Relatorio.fromMap(result);
        _bruto = _bruto + relatorio.bruto;
        _desconto = _desconto + relatorio.desconto;
        _total = _total + relatorio.total;
        relatorioRecuperado.add(relatorio);
      }
    }

    setState(() {
      _relatorio = relatorioRecuperado!;
      _bruto;
      _desconto;
      _total;
    });
    relatorioRecuperado = null;
  }

  _formatarData(String dataString) {
    List dataFormatada = dataString.split("/");
    String ano = dataFormatada[2];
    String mes = dataFormatada[1];
    String dia = dataFormatada[0];

    String _data = ano + "-" + mes + "-" + dia;

    return _data;
  }

  criarDataTable() {
    return tabela.exibirTabela(
        _relatorio, _bruto, _desconto, _total, urlScriptTabela);
  }

  dataAtual() {
    var _now = DateTime.now();
    final DateFormat _formatter = DateFormat('dd/MM/yyyy');
    final String _formatted = _formatter.format(_now);

    return _formatted;
  }

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
    if (dataInicString == "" || dataFinalString == "") {
      dataInicString = dataAtual();
      dataFinalString = dataAtual();
    }
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
                                controller: _controllerDataInic
                                  ..text = dataInicString,
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
                                controller: _controllerDataFinal
                                  ..text = dataFinalString,
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
                                dataInicString = _controllerDataInic.text;
                                dataFinalString = _controllerDataFinal.text;
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
                      padding: EdgeInsets.only(
                          top: 10,
                          left: 12,
                          right: largura > 700 ? largura - 715 - 12 : 12),
                      child: Row(
                        children: [
                          Text(
                            "Relatório:  ",
                            style:
                                new TextStyle(fontSize: 15, color: Colors.blue),
                          ),
                          DropdownButton<String>(
                            value: dropdownValue2,
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
                                dataInicString = _controllerDataInic.text;
                                dataFinalString = _controllerDataFinal.text;
                                dropdownValue2 = newValue!;
                              });
                            },
                            items: _tipoRelatorio
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
                    _relatorio.length > 0
                        ? criarDataTable()
                        : Text("$_mensagem",
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              )));
    });
  }
}
