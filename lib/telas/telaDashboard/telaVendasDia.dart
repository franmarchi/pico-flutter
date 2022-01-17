import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pico/model/entities/Filiais.dart';
import 'package:pico/model/entities/VendaDia.dart';
import 'dart:convert';
import 'package:pico/model/helper/Api.dart';

class TelaVendasDia extends StatefulWidget {
  const TelaVendasDia({Key? key}) : super(key: key);

  @override
  _TelaVendasDiaState createState() => _TelaVendasDiaState();
}

class _TelaVendasDiaState extends State<TelaVendasDia> {
  TextEditingController _controllerDataInic = TextEditingController();
  TextEditingController _controllerDataFinal = TextEditingController();
  String dataInicString = "";
  String dataFinalString = "";
  List<Filiais> _filiais = [];
  List<String> _nomeFiliais = [];
  String dropdownValue = "";
  String _mensagem = "";
  String _opcao = "1";
  Api api = Api();
  String dropdownValue2 = "";
  List<Filiais> _vendedor = [];
  List<String> _nomeVendedor = [];
  List _relatorio = [];
  double _quantidade = 0;
  double _valorTotal = 0;

  var maskFormatterDataInic = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  var maskFormatterDataFinal = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  dataAtual() {
    var _now = DateTime.now();
    final DateFormat _formatter = DateFormat('dd/MM/yyyy');
    final String _formatted = _formatter.format(_now);

    return _formatted;
  }

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
    dataInicString = _controllerDataInic.text;
    dataFinalString = _controllerDataFinal.text;
    String filialEscolhida = "";
    String vendedorEscolhido = "";
    _quantidade = 0;
    _valorTotal = 0;
    if (dropdownValue != "") {
      for (var item in _filiais) {
        if (item.filial == dropdownValue) {
          filialEscolhida = item.codigo;
        }
      }
    }
    if (dropdownValue2 != "") {
      for (var item in _vendedor) {
        if (item.filial == dropdownValue2) {
          vendedorEscolhido = item.codigo;
        }
      }
    }

    List listaTemporaria = await api.buscarRelatorioVendaDia(
        _dataInicial, _dataFinal, filialEscolhida, vendedorEscolhido);

    List? relatorioRecuperado = [];

    if (listaTemporaria.length == 0) {
      setState(() {
        _mensagem = "Não há dados para o período selecionado!";
      });
    }
    for (var item in listaTemporaria) {
      item = jsonDecode(item) as Map;
      var result = item.cast<dynamic, dynamic>();
      VendaDia vendaDia = VendaDia.fromMap(result);
      _quantidade = _quantidade + vendaDia.bruto;
      _valorTotal = _valorTotal + vendaDia.total;
      relatorioRecuperado.add(vendaDia);
    }
    setState(() {
      _relatorio = relatorioRecuperado!;
    });

    relatorioRecuperado = null;
  }

  _criarTabela(relatorio) {
    List<DataRow> list = [];

    for (var item in relatorio) {
      list.add(DataRow(cells: [
        DataCell(Text(item.data)),
        DataCell(Text(item.bruto.toStringAsFixed(2))),
        DataCell(Text(item.desconto.toStringAsFixed(2))),
        DataCell(Text(item.total.toStringAsFixed(2))),
      ]));
    }

    list.add(DataRow(cells: [
      DataCell(
          Text("Total geral", style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text("R\$ " + "${_quantidade.toStringAsFixed(2)}",
          style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text("")),
      DataCell(Text("R\$ " + "${_valorTotal.toStringAsFixed(2)}",
          style: TextStyle(fontWeight: FontWeight.bold))),
    ]));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
              label:
                  Text("Data", style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label:
                  Text("Bruto", style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text("Desconto",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text("Líquido",
                  style: TextStyle(fontWeight: FontWeight.bold)))
        ],
        rows: list,
      ),
    );
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

  void _exibirVendedor() async {
    List listaTemporaria = await api.buscarVendedores();

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
      _vendedor = filiaisRecuperadas!;
      _nomeVendedor = nomeFiliaisRecuperadas;
    });
    filiaisRecuperadas = null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _exibirFiliais();

    _exibirVendedor();
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
                        "Filial:  ",
                        style: new TextStyle(fontSize: 15, color: Colors.blue),
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
                      ),
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
                  child: Row(children: [
                    Text(
                      "Vendedor(a):  ",
                      style: new TextStyle(fontSize: 15, color: Colors.blue),
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
                      items: _nomeVendedor
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ]),
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
                  height: 30,
                ),
                _relatorio.length > 0
                    ? _criarTabela(_relatorio)
                    : Text("$_mensagem")
              ],
            ),
          ),
        ),
      );
    });
  }
}
