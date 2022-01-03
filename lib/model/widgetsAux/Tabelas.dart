import 'dart:js';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pico/model/entities/ItensVendidoVendedor.dart';

class Tabelas {
  Tabelas();

  exibirTabela(_relatorio, _bruto, _desconto, _total, tipo) {
    List<DataRow> list = [];

    if (tipo == "Vendas Sintetico") {
      for (var item in _relatorio) {
        list.add(DataRow(cells: [
          DataCell(Text(item.descricao)),
          DataCell(Text(item.bruto.toStringAsFixed(2))),
          DataCell(Text(item.desconto.toStringAsFixed(2))),
          DataCell(Text(item.total.toStringAsFixed(2))),
        ]));
      }

      list.add(DataRow(cells: [
        DataCell(
            Text("Total", style: new TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("R\$ " + _bruto.toStringAsFixed(2),
            style: new TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("R\$ " + _desconto.toStringAsFixed(2),
            style: new TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("R\$ " + _total.toStringAsFixed(2),
            style: new TextStyle(fontWeight: FontWeight.bold))),
      ]));
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(columns: [
            DataColumn(
                label: Text("Forma de pagto",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Valor Bruto",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Desconto",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Total",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
          ], rows: list));
    } else if (tipo == "Vendas Credito") {
      for (var item in _relatorio) {
        list.add(DataRow(cells: [
          DataCell(Text(item.descricao)),
          DataCell(Text(item.bruto.toStringAsFixed(2))),
          DataCell(Text(item.desconto.toStringAsFixed(2))),
          DataCell(Text(item.total.toStringAsFixed(2))),
        ]));
      }

      list.add(DataRow(cells: [
        DataCell(
            Text("Total", style: new TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(_bruto.toStringAsFixed(2),
            style: new TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(_desconto.toStringAsFixed(0),
            style: new TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("R\$" + _total.toStringAsFixed(2),
            style: new TextStyle(fontWeight: FontWeight.bold))),
      ]));
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(columns: [
            DataColumn(
                label: Text("Forma de pagto",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Valor Bruto",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Desconto",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Total",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
          ], rows: list));
    } else if (tipo == "Vendas Analitico") {
      List<DataRow> listCartao = [];
      List<DataRow> listDebito = [];
      List<DataRow> listDinheiro = [];
      List<DataRow> listPix = [];
      double brutoCartaoCredito = 0.0;
      double subTotalCartaoCredito = 0.0;
      double totalCartaoCredito = 0.0;
      double brutoCartaoDebito = 0.0;
      double subTotalCartaoDebito = 0.0;
      double totalCartaoDebito = 0.0;
      double brutoDinheiro = 0.0;
      double subTotalDinheiro = 0.0;
      double totalDinheiro = 0.0;
      double brutoPix = 0.0;
      double subTotalPix = 0.0;
      double totalPix = 0.0;

      for (var item in _relatorio) {
        if (item.descricao == "CARTÃO DE CREDITO") {
          subTotalCartaoCredito = subTotalCartaoCredito + item.subtotal;
          brutoCartaoCredito = brutoCartaoCredito + item.desconto;
          totalCartaoCredito = totalCartaoCredito + item.total;
          listCartao.add(DataRow(cells: [
            DataCell(Text(item.venda)),
            DataCell(Text(item.apelido)),
            DataCell(Text("R\$ ${item.subtotal.toStringAsFixed(2)}")),
            DataCell(Text(item.desconto.toStringAsFixed(2))),
            DataCell(Text(item.tipo)),
            DataCell(Text(item.nome)),
            DataCell(Text(item.total.toStringAsFixed(2))),
          ]));
        } else if (item.descricao == "CARTÃO DE DÉBITO") {
          subTotalCartaoDebito = subTotalCartaoDebito + item.subtotal;
          brutoCartaoDebito = brutoCartaoDebito + item.desconto;
          totalCartaoDebito = totalCartaoDebito + item.total;
          listDebito.add(DataRow(cells: [
            DataCell(Text(item.venda)),
            DataCell(Text(item.apelido)),
            DataCell(Text(item.subtotal.toStringAsFixed(2))),
            DataCell(Text(item.desconto.toStringAsFixed(2))),
            DataCell(Text(item.tipo)),
            DataCell(Text(item.nome)),
            DataCell(Text(item.total.toStringAsFixed(2))),
          ]));
        } else if (item.descricao == "DINHEIRO") {
          subTotalDinheiro = subTotalDinheiro + item.subtotal;
          brutoDinheiro = brutoDinheiro + item.desconto;
          totalDinheiro = totalDinheiro + item.total;
          listDebito.add(DataRow(cells: [
            DataCell(Text(item.venda)),
            DataCell(Text(item.apelido)),
            DataCell(Text(item.subtotal.toStringAsFixed(2))),
            DataCell(Text(item.desconto.toStringAsFixed(2))),
            DataCell(Text(item.tipo)),
            DataCell(Text(item.nome)),
            DataCell(Text(item.total.toStringAsFixed(2))),
          ]));
        } else if (item.descricao == "PIX") {
          subTotalPix = subTotalPix + item.subtotal;
          brutoPix = brutoPix + item.desconto;
          totalPix = totalPix + item.total;
          listPix.add(DataRow(cells: [
            DataCell(Text(item.venda)),
            DataCell(Text(item.apelido)),
            DataCell(Text(item.subtotal.toStringAsFixed(2))),
            DataCell(Text(item.desconto.toStringAsFixed(2))),
            DataCell(Text(item.tipo)),
            DataCell(Text(item.nome)),
            DataCell(Text(item.total.toStringAsFixed(2))),
          ]));
        }
      }

      listCartao.add(DataRow(cells: [
        DataCell(Text("Total", style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("")),
        DataCell(Text("R\$ " + subTotalCartaoCredito.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("R \$ " + brutoCartaoCredito.toStringAsFixed(0),
            style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text("R\$ " + totalCartaoCredito.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.bold))),
      ]));
      listDebito.add(DataRow(cells: [
        DataCell(Text("Total", style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("")),
        DataCell(Text("R\$ " + subTotalCartaoDebito.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("R \$ " + brutoCartaoDebito.toStringAsFixed(0),
            style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text("R\$ " + totalCartaoDebito.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.bold))),
      ]));
      listDinheiro.add(DataRow(cells: [
        DataCell(Text("Total", style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("")),
        DataCell(Text("R\$ " + subTotalDinheiro.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("R \$ " + brutoDinheiro.toStringAsFixed(0),
            style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text("R\$ " + totalDinheiro.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.bold))),
      ]));
      listPix.add(DataRow(cells: [
        DataCell(Text("Total", style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("")),
        DataCell(Text("R\$ " + subTotalPix.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("R \$ " + brutoPix.toStringAsFixed(0),
            style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text("R\$ " + totalPix.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.bold))),
      ]));

      /* list.add(DataRow(cells: [
        DataCell(Text("Total")),
        DataCell(Text("")),
        DataCell(Text(_bruto.toStringAsFixed(2))),
        DataCell(Text(_desconto.toStringAsFixed(0))),
        DataCell(Text("")),
        DataCell(Text(_total.toStringAsFixed(2))),
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text("")),
      ]));*/
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 15),
                child: Text("Forma de pagamento: Cartão de Crédito",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              listCartao.length > 1
                  ? DataTable(columns: [
                      DataColumn(
                          label: Text("Venda",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Vendedor (a)",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Subtotal",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Desconto",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Tipo",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Cliente",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Total",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ], rows: listCartao)
                  : Text("Não há dados para pagamento com cartão de crédito",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      )),
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 15),
                child: Text("Forma de pagamento: Cartão de Débito",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              listDebito.length > 1
                  ? DataTable(columns: [
                      DataColumn(
                          label: Text("Venda",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Vendedor (a)",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Subtotal",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Desconto",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Tipo",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Cliente",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Total",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ], rows: listDebito)
                  : Text("Não há dados para pagamento com cartão de débito",
                      style: TextStyle(fontWeight: FontWeight.w300)),
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 15),
                child: Text("Forma de pagamento: Dinheiro",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              listDinheiro.length > 1
                  ? DataTable(columns: [
                      DataColumn(
                          label: Text("Venda",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Vendedor (a)",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Subtotal",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Desconto",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Tipo",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Cliente",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Total",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ], rows: listDinheiro)
                  : Text("Não há dados para pagamento em dinheiro",
                      style: TextStyle(fontWeight: FontWeight.w300)),
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 15),
                child: Text("Forma de Pagamento: PIX",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              listPix.length > 1
                  ? DataTable(columns: [
                      DataColumn(
                          label: Text("Venda",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Vendedor (a)",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Subtotal",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Desconto",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Tipo",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Cliente",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Total",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ], rows: listPix)
                  : Text("Não há dados para pagamento em PIX",
                      style: TextStyle(fontWeight: FontWeight.w300)),
              Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 15),
                  child: Text(
                      "Valor total das vendas: R\$ ${_total.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
            ],
          ));
    } else if (tipo == "Vendas Canceladas") {
      for (var item in _relatorio) {
        list.add(DataRow(cells: [
          DataCell(Text(item.venda)),
          DataCell(Text(item.apelido)),
          DataCell(Text(item.subtotal.toStringAsFixed(2))),
          DataCell(Text(item.desconto.toStringAsFixed(2))),
          DataCell(Text(item.descp)),
          DataCell(Text(item.tipo)),
          DataCell(Text(item.descricao)),
          DataCell(Text(item.nome)),
          DataCell(Text(item.total.toStringAsFixed(2))),
        ]));
      }

      list.add(DataRow(cells: [
        DataCell(
            Text("Total", style: new TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("")),
        DataCell(Text("R\$ " + _bruto.toStringAsFixed(2),
            style: new TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("R\$ " + _desconto.toStringAsFixed(0),
            style: new TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text("R\$ " + _total.toStringAsFixed(2),
            style: new TextStyle(fontWeight: FontWeight.bold))),
      ]));
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(columns: [
            DataColumn(
                label: Text("Venda",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Vendedor (a)",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Subtotal",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Desconto",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Descp.",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Tipo",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Forma de pagto",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Cliente",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Total",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
          ], rows: list));
    } else if (tipo == "Itens Bonificados" || tipo == "Itens Vendidos") {
      for (var item in _relatorio) {
        list.add(DataRow(cells: [
          DataCell(Text(item.nome)),
          DataCell(Text(item.quantidade.toString())),
          DataCell(Text(item.total.toStringAsFixed(2))),
        ]));
      }

      list.add(DataRow(cells: [
        DataCell(
            Text("Total", style: new TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(_desconto.toString(),
            style: new TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("R\$ " + _total.toStringAsFixed(2),
            style: new TextStyle(fontWeight: FontWeight.bold))),
      ]));

      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(columns: [
            DataColumn(
                label: Text("Produto",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Quantidade",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Valor unitário",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
          ], rows: list));
    } else if (tipo == "Itens Vendidos por Vendedor") {
      List<List<ItensVendidoVendedor>> listaDeLista = [];
      bool? adicionado;
      double _qtdVendedor = 0.0;
      double _totalVendedor = 0.0;
      for (var item in _relatorio) {
        if (listaDeLista.isEmpty) {
          List<ItensVendidoVendedor> list = [item];
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
            List<ItensVendidoVendedor> list = [item];
            listaDeLista.add(list);
          }
        }
      }

      criarRows(lista) {
        List<DataRow> list = [];
        _totalVendedor = 0;
        _qtdVendedor = 0;

        for (var item in lista) {
          _totalVendedor = _totalVendedor + item.total;
          _qtdVendedor = _qtdVendedor + item.quantidade;
          list.add(DataRow(cells: [
            DataCell(Text(item.nome)),
            DataCell(Text(item.quantidade.toString())),
            DataCell(Text(item.total.toStringAsFixed(2))),
          ]));
        }
        list.add(DataRow(cells: [
          DataCell(
              Text("Total", style: TextStyle(fontWeight: FontWeight.bold))),
          DataCell(Text(_qtdVendedor.toStringAsFixed(0),
              style: TextStyle(fontWeight: FontWeight.bold))),
          DataCell(Text("R\$ " + _totalVendedor.toStringAsFixed(2),
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
                  scrollDirection: Axis.vertical,
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
                            label: Text("Total",
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
                        "Quantidade total de itens vendidos: ${_desconto.toStringAsFixed(0)}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "Valor total das vendas: R\$ ${_total.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ],
            ))
      ]);

      /*SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(columns: [
            DataColumn(
                label: Text("Vendedor (a)",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Produto",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Quantidade",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Total",
                    style: new TextStyle(fontWeight: FontWeight.bold))),
          ], rows: list));*/
    }
  }
}
