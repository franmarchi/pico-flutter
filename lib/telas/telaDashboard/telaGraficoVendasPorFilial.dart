import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
                          onPressed: () {}),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )));
    });
  }
}
