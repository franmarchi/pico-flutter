import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pico/model/entities/Filiais.dart';
import 'package:pico/model/entities/ResumoVendas.dart';
import 'package:pico/model/entities/VendaDia.dart';
import 'dart:convert';
import 'package:pico/model/helper/Api.dart';

class TelaRelatorioResumoVendas extends StatefulWidget {
  const TelaRelatorioResumoVendas({Key? key}) : super(key: key);

  @override
  _TelaRelatorioResumoVendasState createState() =>
      _TelaRelatorioResumoVendasState();
}

class _TelaRelatorioResumoVendasState extends State<TelaRelatorioResumoVendas> {
  TextEditingController _controllerDataInic = TextEditingController();
  TextEditingController _controllerDataFinal = TextEditingController();
  //String dataInicString = "";
  //String dataFinalString = "";
  List<Filiais> _filiais = [];
  List<String> _nomeFiliais = [];
  String dropdownValue = "";
  String _mensagem = "";
  double _custo = 0;
  double _valorTotal = 0;

  Api api = Api();
  String dropdownValue2 = "";
  //List<Filiais> _vendedor = [];

  List _relatorio = [];

  var maskFormatterDataInic = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  var maskFormatterDataFinal = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

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
    // dataInicString = _controllerDataInic.text;
    // dataFinalString = _controllerDataFinal.text;
    String filialEscolhida = "";
    _custo = 0;
    _valorTotal = 0;
    if (dropdownValue != "") {
      for (var item in _filiais) {
        if (item.filial == dropdownValue) {
          filialEscolhida = item.codigo;
        }
      }
    }

    List listaTemporaria = await api.buscarRelatorioResumoVenda(
        _dataInicial, _dataFinal, filialEscolhida);

    List? relatorioRecuperado = [];

    if (listaTemporaria.length == 0) {
      setState(() {
        _mensagem = "Não há dados para o período selecionado!";
      });
    }
    for (var item in listaTemporaria) {
      item = jsonDecode(item) as Map;
      var result = item.cast<dynamic, dynamic>();
      ResumoVendas resumoVendas = ResumoVendas.fromMap(result);
      _custo = _custo + resumoVendas.custo;
      _valorTotal = _valorTotal + resumoVendas.total;
      relatorioRecuperado.add(resumoVendas);
    }
    print(relatorioRecuperado);
    setState(() {
      _relatorio = relatorioRecuperado!;
    });

    relatorioRecuperado = null;
  }

  _criarTabela(relatorio) {
    List<List<ResumoVendas>> listaDeLista = [];
    bool? adicionado;
    double _totalVendedor = 0.0;
    double _custoTotal = 0.0;
    for (var item in _relatorio) {
      if (listaDeLista.isEmpty) {
        List<ResumoVendas> list = [item];
        listaDeLista.add(list);
      } else {
        for (var itemLista in listaDeLista) {
          for (var objitem in itemLista) {
            if (objitem.apelido == item.apelido) {
              itemLista.add(item);
              adicionado = true;
              break;
            } else {
              adicionado = false;
            }
          }
        }
        if (adicionado == false) {
          List<ResumoVendas> list = [item];
          listaDeLista.add(list);
        }
      }
    }
    criarRows(lista) {
      List<DataRow> list = [];
      _totalVendedor = 0;
      _custoTotal = 0;

      for (var item in lista) {
        _totalVendedor = _totalVendedor + item.total;
        _custoTotal = _custoTotal + item.custo;
        list.add(DataRow(cells: [
          DataCell(Text(item.nome)),
          DataCell(Text(item.qtd)),
          DataCell(Text(item.total.toStringAsFixed(2))),
          DataCell(Text(item.custo.toStringAsFixed(2))),
        ]));
      }
      list.add(DataRow(cells: [
        DataCell(Text("Total", style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("", style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("R\$ " + _totalVendedor.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("R\$ " + _custoTotal.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.bold))),
      ]));
      return list;
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: listaDeLista.length,
          itemBuilder: (context, index) {
            final itemLista = listaDeLista[index];
            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Vendedor(a): ${itemLista[0].apelido}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    DataTable(columns: [
                      DataColumn(
                          label: Text("Produto",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Quantidade",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Valor",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Custo",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ], rows: criarRows(itemLista)),
                  ],
                ));
          }),
      SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                      "Custo total de itens vendidos: ${_custo.toStringAsFixed(0)}",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                      "Valor total das vendas: R\$ ${_valorTotal.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ],
          ))
    ]);
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
