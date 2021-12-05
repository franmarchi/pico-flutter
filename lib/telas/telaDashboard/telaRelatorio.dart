import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pico/model/entities/Filiais.dart';
import 'package:pico/model/entities/Relatorio.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:pico/model/helper/Api.dart';
import 'package:pico/telas/telasLogin/telaAtualizarSenha1.dart';
import 'package:pico/telas/telasLogin/telaLogin.dart';

class TelaRelatorio extends StatefulWidget {
  const TelaRelatorio({Key? key}) : super(key: key);

  @override
  _TelaRelatorioState createState() => _TelaRelatorioState();
}

class _TelaRelatorioState extends State<TelaRelatorio> {
  TextEditingController _controllerDataInic = TextEditingController();
  TextEditingController _controllerDataFinal = TextEditingController();
  String data1 = "";
  Api api = Api();
  List<Relatorio> _relatorio = [];
  String dropdownValue = "";
  double _bruto = 0;
  double _desconto = 0;
  double _total = 0;
  List<Filiais> _filiais = [];
  List<String> _nomeFiliais = [];
  String _mensagem = "";

  var maskFormatterData = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  void _exibirRelatorio() async {
    String _dataInicial = _formatarData(_controllerDataInic.text);
    String _dataFinal = _formatarData(_controllerDataFinal.text);
    String filialEscolhida = "";
    if (dropdownValue != "") {
      for (var item in _filiais) {
        if (item.filial == dropdownValue) {
          filialEscolhida = item.codigo;
        }
      }
    }

    List listaTemporaria =
        await api.buscarRelatorio(_dataInicial, _dataFinal, filialEscolhida);

    List<Relatorio>? relatorioRecuperado = [];

    if (listaTemporaria.length == 0) {
      setState(() {
        _mensagem = "Não há dados para o período selecionado";
      });
    }
    _bruto = 0;
    _desconto = 0;
    _total = 0;
    for (var item in listaTemporaria) {
      item = jsonDecode(item) as Map;
      var result = item.cast<dynamic, dynamic>();
      Relatorio relatorio = Relatorio.fromMap(result);
      _bruto = _bruto + relatorio.bruto;
      _desconto = _desconto + relatorio.desconto;
      _total = _total + relatorio.total;
      relatorioRecuperado.add(relatorio);
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
    List<DataRow> list = [];

    for (var item in _relatorio) {
      list.add(DataRow(cells: [
        DataCell(Text(item.descricao)),
        DataCell(Text(item.bruto.toStringAsFixed(2))),
        DataCell(Text(item.desconto.toStringAsFixed(2))),
        DataCell(Text(item.total.toStringAsFixed(2))),
      ]));
    }

    list.add(DataRow(cells: [
      DataCell(Text("Total")),
      DataCell(Text(_bruto.toStringAsFixed(2))),
      DataCell(Text(_desconto.toStringAsFixed(2))),
      DataCell(Text(_total.toStringAsFixed(2))),
    ]));
    return Scrollbar(
        scrollbarOrientation: ScrollbarOrientation.top,
        child: DataTable(columns: [
          DataColumn(label: Text("Descri.")),
          DataColumn(label: Text("Bruto")),
          DataColumn(label: Text("Desc.")),
          DataColumn(label: Text("Total")),
        ], rows: list));
  }

  criarTabela(largura) {
    List<TableRow> list = [];

    if (_relatorio.length > 0) {
      list.add(TableRow(children: [
        Container(
          alignment: Alignment.center,
          child: Text("Forma de Pagamento",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900)),
          padding: EdgeInsets.all(4.0),
        ),
        Container(
          alignment: Alignment.center,
          child: Text("Bruto",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900)),
          padding: EdgeInsets.all(4.0),
        ),
        Container(
          alignment: Alignment.center,
          child: Text("Desc",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900)),
          padding: EdgeInsets.all(4.0),
        ),
        Container(
          alignment: Alignment.center,
          child: Text("Liquido",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900)),
          padding: EdgeInsets.all(4.0),
        ),
      ]));
    }

    for (var item in _relatorio) {
      list.add(TableRow(children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            item.descricao,
            style: TextStyle(fontSize: 13.0),
          ),
          padding: EdgeInsets.all(4.0),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            item.bruto.toStringAsFixed(2),
            style: TextStyle(fontSize: 13.0),
          ),
          padding: EdgeInsets.all(4.0),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            item.desconto.toStringAsFixed(2),
            style: TextStyle(fontSize: 13.0),
          ),
          padding: EdgeInsets.all(4.0),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            item.total.toStringAsFixed(2),
            style: TextStyle(fontSize: 13.0),
          ),
          padding: EdgeInsets.all(4.0),
        ),
      ]));
    }

    if (_relatorio.length > 0) {
      list.add(TableRow(children: [
        Text("Total"),
        Text(_bruto.toStringAsFixed(2)),
        Text(_desconto.toStringAsFixed(2)),
        Text(_total.toStringAsFixed(2))
      ]));
    }

    return Table(
      defaultColumnWidth:
          FixedColumnWidth(largura < 800 ? largura * 0.20 : 150),
      border: TableBorder.all(),
      children: list,
    );
  }

  dataAtual() {
    var now = DateTime.now();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(now);

    return formatted;
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
                                controller: _controllerDataInic
                                  ..text = dataAtual(),
                                inputFormatters: [maskFormatterData],
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
                                  ..text = dataAtual(),
                                inputFormatters: [maskFormatterData],
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
                          right: largura > 700 ? largura - 715 - 12 : 12),
                      child: Row(
                        children: [
                          Text(
                            "Filiais  ",
                            style:
                                new TextStyle(fontSize: 15, color: Colors.blue),
                          ),
                          Expanded(
                              child: DropdownButton<String>(
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
                          ))
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
                    /*Card(
                      child: Padding(
                          padding: EdgeInsets.all(17),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Resumo do relatorio"),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Bruto: R\$ ${_bruto.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.green),
                                  ),
                                  Text(
                                    "Desconto: R\$ ${_desconto.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.red),
                                  ),
                                  Text(
                                    "Total: R\$ ${_total.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.blue),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),*/
                    SizedBox(
                      height: 20,
                    ),

                    //criarTabela(largura)
                    _relatorio.length > 0
                        ? criarDataTable()
                        : Text("$_mensagem"),
                  ],
                ),
              )));
    });
  }
}
