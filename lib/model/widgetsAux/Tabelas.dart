import 'dart:js';

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
    } else if (tipo == "Itens Bonificados" || tipo == "Itens Vendidos") {
      for (var item in _relatorio) {
        list.add(DataRow(cells: [
          DataCell(Text(item.nome)),
          DataCell(Text(item.quantidade.toString())),
          DataCell(Text(item.total.toStringAsFixed(2))),
        ]));
      }

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
      for (var item in _relatorio) {
        if (listaDeLista.isEmpty) {
          List<ItensVendidoVendedor> list = [item];
          listaDeLista.add(list);
        } else {
          for (var itemLista in listaDeLista) {
            for (var objitem in itemLista) {
              if (objitem.apelido == item.apelido) {
                itemLista.add(item);
                print("Dentro do if: " + listaDeLista.toString());
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
        for (var item in lista) {
          list.add(DataRow(cells: [
            DataCell(Text(item.nome)),
            DataCell(Text(item.quantidade.toString())),
            DataCell(Text(item.total.toStringAsFixed(2))),
          ]));
        }
        return list;
      }

      return ListView.builder(
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
                          "Vendedor: ${itemLista[0].apelido}",
                          style: TextStyle(fontSize: 18),
                        )),
                    DataTable(columns: [
                      DataColumn(
                          label: Text("Produto",
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Quantidade",
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Total",
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold))),
                    ], rows: criarRows(itemLista)),
                  ],
                ));
          });

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
    } else if (tipo == "Vendas Credito") {
      for (var item in _relatorio) {
        list.add(DataRow(cells: [
          DataCell(Text(item.cod)),
          DataCell(Text(item.descricao)),
          DataCell(Text(item.bruto.toStringAsFixed(2))),
          DataCell(Text(item.desconto.toStringAsFixed(2))),
          DataCell(Text(item.total.toStringAsFixed(2))),
        ]));
      }

      list.add(DataRow(cells: [
        DataCell(
            Text("Total", style: new TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("")),
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
            DataColumn(label: Text("Codigo")),
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
      double brutoCartaoCredito = 0.0;
      double subTotalCartaoCredito = 0.0;
      double totalCartaoCredito = 0.0;
      double brutoCartaoDebito = 0.0;
      double subTotalCartaoDebito = 0.0;
      double totalCartaoDebito = 0.0;
      double brutoDinheiro = 0.0;
      double subTotalDinheiro = 0.0;
      double totalDinheiro = 0.0;
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
            DataCell(Text(item.descp)),
            DataCell(Text(item.total.toStringAsFixed(2))),
            DataCell(Text(item.tipo)),
            DataCell(Text(item.nome)),
          ]));
        } else if (item.descricao == "CARTÃO DE DÉBITO") {
          listDebito.add(DataRow(cells: [
            DataCell(Text(item.venda)),
            DataCell(Text(item.apelido)),
            DataCell(Text(item.subtotal.toStringAsFixed(2))),
            DataCell(Text(item.desconto.toStringAsFixed(2))),
            DataCell(Text(item.descp)),
            DataCell(Text(item.total.toStringAsFixed(2))),
            DataCell(Text(item.tipo)),
            DataCell(Text(item.nome)),
          ]));
        } else if (item.descricao == "DINHEIRO") {
          listDebito.add(DataRow(cells: [
            DataCell(Text(item.venda)),
            DataCell(Text(item.apelido)),
            DataCell(Text(item.subtotal.toStringAsFixed(2))),
            DataCell(Text(item.desconto.toStringAsFixed(2))),
            DataCell(Text(item.descp)),
            DataCell(Text(item.total.toStringAsFixed(2))),
            DataCell(Text(item.tipo)),
            DataCell(Text(item.nome)),
          ]));
        }
      }

      listCartao.add(DataRow(cells: [
        DataCell(Text("Total")),
        DataCell(Text("")),
        DataCell(Text(brutoCartaoCredito.toStringAsFixed(2))),
        DataCell(Text(subTotalCartaoCredito.toStringAsFixed(0))),
        DataCell(Text("")),
        DataCell(Text(totalCartaoCredito.toStringAsFixed(2))),
        DataCell(Text("")),
        DataCell(Text("")),
      ]));
      listDebito.add(DataRow(cells: [
        DataCell(Text("Total")),
        DataCell(Text("")),
        DataCell(Text(brutoCartaoDebito.toStringAsFixed(2))),
        DataCell(Text(subTotalCartaoDebito.toStringAsFixed(0))),
        DataCell(Text("")),
        DataCell(Text(totalCartaoDebito.toStringAsFixed(2))),
        DataCell(Text("")),
        DataCell(Text("")),
      ]));
      listDinheiro.add(DataRow(cells: [
        DataCell(Text("Total")),
        DataCell(Text("")),
        DataCell(Text(brutoDinheiro.toStringAsFixed(2))),
        DataCell(Text(subTotalDinheiro.toStringAsFixed(0))),
        DataCell(Text("")),
        DataCell(Text(totalDinheiro.toStringAsFixed(2))),
        DataCell(Text("")),
        DataCell(Text("")),
      ]));

      list.add(DataRow(cells: [
        DataCell(Text("Total")),
        DataCell(Text("")),
        DataCell(Text(_bruto.toStringAsFixed(2))),
        DataCell(Text(_desconto.toStringAsFixed(0))),
        DataCell(Text("")),
        DataCell(Text(_total.toStringAsFixed(2))),
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text("")),
      ]));
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("Vendas Cartão Credito",
                    style: TextStyle(fontSize: 10)),
              ),
              DataTable(columns: [
                DataColumn(label: Text("Venda")),
                DataColumn(label: Text("Apelido")),
                DataColumn(label: Text("Subtotal.")),
                DataColumn(label: Text("Desconto")),
                DataColumn(label: Text("Descp.")),
                DataColumn(label: Text("Total")),
                DataColumn(label: Text("Tipo")),
                DataColumn(label: Text("Nome")),
              ], rows: listCartao),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("Vendas Cartão Debito",
                    style: TextStyle(fontSize: 10)),
              ),
              DataTable(columns: [
                DataColumn(label: Text("Venda")),
                DataColumn(label: Text("Apelido")),
                DataColumn(label: Text("Subtotal.")),
                DataColumn(label: Text("Desconto")),
                DataColumn(label: Text("Descp.")),
                DataColumn(label: Text("Total")),
                DataColumn(label: Text("Tipo")),
                DataColumn(label: Text("Nome")),
              ], rows: listDebito),
              listDinheiro.length > 0
                  ? DataTable(columns: [
                      DataColumn(label: Text("Venda")),
                      DataColumn(label: Text("Apelido")),
                      DataColumn(label: Text("Subtotal.")),
                      DataColumn(label: Text("Desconto")),
                      DataColumn(label: Text("Descp.")),
                      DataColumn(label: Text("Total")),
                      DataColumn(label: Text("Tipo")),
                      DataColumn(label: Text("Nome")),
                    ], rows: listDinheiro)
                  : Text("não há dados em dinheiro")
            ],
          ));
    }
  }
}
