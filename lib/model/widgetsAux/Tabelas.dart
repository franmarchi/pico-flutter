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
    } else if (tipo == "Itens Bonificados") {
      for (var item in _relatorio) {
        list.add(DataRow(cells: [
          DataCell(Text(item.nome)),
          DataCell(Text(item.quantidade)),
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
    }
  }
}
