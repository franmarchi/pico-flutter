import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pico/model/entities/ABCProdutos.dart';
import 'package:pico/model/entities/Filiais.dart';
import 'dart:convert';
import 'package:pico/model/helper/Api.dart';

class TelaRelatorioABCProdutos extends StatefulWidget {
  const TelaRelatorioABCProdutos({Key? key}) : super(key: key);

  @override
  _TelaRelatorioABCProdutosState createState() =>
      _TelaRelatorioABCProdutosState();
}

class _TelaRelatorioABCProdutosState extends State<TelaRelatorioABCProdutos> {
  TextEditingController _controllerDataInic = TextEditingController();
  TextEditingController _controllerDataFinal = TextEditingController();
  String dataInicString = "";
  String dataFinalString = "";
  List<Filiais> _filiais = [];
  List<String> _nomeFiliais = [];
  String dropdownValue = "";
  String dropdownValue2 = "";
  List<Filiais> _produto = [];
  List<String> _nomeProduto = [];
  String _opcao = "1";
  String _mensagem = "";
  List _relatorio = [];
  double _quantidade = 0;
  double _valorTotal = 0;

  Api api = Api();

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

  void _exibirProduto() async {
    List listaTemporaria = await api.buscarProduto();

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
      _produto = filiaisRecuperadas!;
      _nomeProduto = nomeFiliaisRecuperadas;
    });
    filiaisRecuperadas = null;
  }

  void _exibirRelatorio() async {
    String _dataInicial = _formatarData(_controllerDataInic.text);
    String _dataFinal = _formatarData(_controllerDataFinal.text);
    dataInicString = _controllerDataInic.text;
    dataFinalString = _controllerDataFinal.text;
    String filialEscolhida = "";
    String produtoEscolhido = "";
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
      for (var item in _produto) {
        if (item.filial == dropdownValue2) {
          produtoEscolhido = item.codigo;
        }
      }
    }

    List listaTemporaria = await api.buscarRelatorioABCProdutos(
        _dataInicial, _dataFinal, filialEscolhida, _opcao, produtoEscolhido);

    List? relatorioRecuperado = [];

    if (listaTemporaria.length == 0) {
      setState(() {
        _mensagem = "Não há dados para o período selecionado!";
      });
    }
    for (var item in listaTemporaria) {
      item = jsonDecode(item) as Map;
      var result = item.cast<dynamic, dynamic>();
      ABCProdutos abcProdutos = ABCProdutos.fromMap(result);
      _quantidade = _quantidade + abcProdutos.qtd;
      _valorTotal = _valorTotal + abcProdutos.total;
      relatorioRecuperado.add(abcProdutos);
    }
    setState(() {
      _relatorio = relatorioRecuperado!;
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

  _criarTabela(relatorio) {
    List<DataRow> list = [];

    for (var item in relatorio) {
      list.add(DataRow(cells: [
        DataCell(Text(item.nome)),
        DataCell(Text(item.und)),
        DataCell(Text(item.qtd.toStringAsFixed(0))),
        DataCell(Text(item.precoMedio)),
        DataCell(Text(item.total.toStringAsFixed(2))),
        DataCell(Text(item.lucratividade)),
      ]));
    }

    list.add(DataRow(cells: [
      DataCell(
          Text("Total geral", style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text("")),
      DataCell(
          Text("$_quantidade", style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text("")),
      DataCell(Text("R\$ " + "${_valorTotal.toStringAsFixed(2)}",
          style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text("")),
    ]));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
              label: Text("Nome do Produto",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label:
                  Text("UND", style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label:
                  Text("QTD", style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text("Preço Médio",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text("Valor Total",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label:
                  Text("Lucro", style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        rows: list,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _exibirFiliais();
    _exibirProduto();
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
                        "Local:  ",
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
                  child: Row(
                    children: [
                      Text(
                        "Grupo:  ",
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
                        items: _nomeProduto
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
                Row(
                  children: [
                    Radio(
                        value: "1",
                        groupValue: _opcao,
                        onChanged: (String? escolha) {
                          setState(() {
                            _opcao = escolha!;
                          });
                        }),
                    Text("Quantidade")
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: "2",
                        groupValue: _opcao,
                        onChanged: (String? escolha) {
                          setState(() {
                            _opcao = escolha!;
                          });
                        }),
                    Text("Valor")
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: "3",
                        groupValue: _opcao,
                        onChanged: (String? escolha) {
                          setState(() {
                            _opcao = escolha!;
                          });
                        }),
                    Text("Lucratividade"),
                  ],
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
