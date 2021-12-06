import 'package:flutter/material.dart';

class Tabelas {
  Tabelas();

  exibirTabela(_relatorio, _bruto, _desconto, _total, tipo) {
    List<DataRow> list = [];

    if (tipo == "") {
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
    } else if (tipo == "Itens Bonificados" || tipo == "Itens Vendidos") {
      for (var item in _relatorio) {
        list.add(DataRow(cells: [
          DataCell(Text(item.nome)),
          DataCell(Text(item.quantidade.toString())),
          DataCell(Text(item.total.toStringAsFixed(2))),
        ]));
      }

      list.add(DataRow(cells: [
        DataCell(Text("Total")),
        DataCell(Text(_desconto.toStringAsFixed(0))),
        DataCell(Text(_total.toStringAsFixed(0))),
      ]));
      return Scrollbar(
          scrollbarOrientation: ScrollbarOrientation.top,
          child: DataTable(columns: [
            DataColumn(label: Text("Nome")),
            DataColumn(label: Text("Quant.")),
            DataColumn(label: Text("Total")),
          ], rows: list));
    } else if (tipo == "Itens Vendidos Vendedor") {
      for (var item in _relatorio) {
        list.add(DataRow(cells: [
          DataCell(Text(item.apelido)),
          DataCell(Text(item.nome)),
          DataCell(Text(item.quantidade.toString())),
          DataCell(Text(item.total.toStringAsFixed(2))),
        ]));
      }

      list.add(DataRow(cells: [
        DataCell(Text("Total")),
        DataCell(Text("")),
        DataCell(Text(_desconto.toStringAsFixed(0))),
        DataCell(Text(_total.toStringAsFixed(0))),
      ]));
      return Scrollbar(
          scrollbarOrientation: ScrollbarOrientation.top,
          child: DataTable(columns: [
            DataColumn(label: Text("Nome")),
            DataColumn(label: Text("Produto")),
            DataColumn(label: Text("Quant.")),
            DataColumn(label: Text("Total")),
          ], rows: list));
    } else if (tipo == "Vendas Canceladas") {
      for (var item in _relatorio) {
        list.add(DataRow(cells: [
          DataCell(Text(item.venda)),
          DataCell(Text(item.apelido)),
          DataCell(Text(item.subtotal.toStringAsFixed(2))),
          DataCell(Text(item.desconto.toStringAsFixed(2))),
          DataCell(Text(item.descp)),
          DataCell(Text(item.total.toStringAsFixed(2))),
          DataCell(Text(item.tipo)),
          DataCell(Text(item.descricao)),
          DataCell(Text(item.nome)),
        ]));
      }

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
      return Scrollbar(
          scrollbarOrientation: ScrollbarOrientation.top,
          child: DataTable(columns: [
            DataColumn(label: Text("Venda")),
            DataColumn(label: Text("Apelido")),
            DataColumn(label: Text("Subtotal.")),
            DataColumn(label: Text("Desconto")),
            DataColumn(label: Text("Descp.")),
            DataColumn(label: Text("Total")),
            DataColumn(label: Text("Tipo")),
            DataColumn(label: Text("Desc.")),
            DataColumn(label: Text("Nome")),
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
        DataCell(Text("Total")),
        DataCell(Text("")),
        DataCell(Text(_bruto.toStringAsFixed(2))),
        DataCell(Text(_desconto.toStringAsFixed(0))),
        DataCell(Text(_total.toStringAsFixed(2))),
      ]));
      return Scrollbar(
          scrollbarOrientation: ScrollbarOrientation.top,
          child: DataTable(columns: [
            DataColumn(label: Text("Codigo")),
            DataColumn(label: Text("Desc.")),
            DataColumn(label: Text("Bruto")),
            DataColumn(label: Text("Desconto")),
            DataColumn(label: Text("Total")),
          ], rows: list));
    } else if (tipo == "Vendas Detalhadas") {
      for (var item in _relatorio) {
        list.add(DataRow(cells: [
          DataCell(Text(item.venda)),
          DataCell(Text(item.apelido)),
          DataCell(Text(item.subtotal.toStringAsFixed(2))),
          DataCell(Text(item.desconto.toStringAsFixed(2))),
          DataCell(Text(item.descp)),
          DataCell(Text(item.total.toStringAsFixed(2))),
          DataCell(Text(item.tipo)),
          DataCell(Text(item.descricao)),
          DataCell(Text(item.nome)),
        ]));
      }

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
      return Scrollbar(
          scrollbarOrientation: ScrollbarOrientation.top,
          child: DataTable(columns: [
            DataColumn(label: Text("Venda")),
            DataColumn(label: Text("Apelido")),
            DataColumn(label: Text("Subtotal.")),
            DataColumn(label: Text("Desconto")),
            DataColumn(label: Text("Descp.")),
            DataColumn(label: Text("Total")),
            DataColumn(label: Text("Tipo")),
            DataColumn(label: Text("Desc.")),
            DataColumn(label: Text("Nome")),
          ], rows: list));
    }
  }
}
