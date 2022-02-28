import 'package:flutter/material.dart';

class RelatorioGerencialGraficoVendasporAno {
  String _mes = "";
  double _total = 0;

  RelatorioGerencialGraficoVendasporAno();

  String get mes {
    return _mes;
  }

  set mes(String mes) {
    this._mes = mes;
  }

  double get total {
    return _total;
  }

  set total(double total) {
    this._total = total;
  }

  RelatorioGerencialGraficoVendasporAno.fromMap(Map retorno) {
    this.mes = retorno["mes"] ?? "";
    this.total = double.parse(retorno["Total"] ?? 0);
  }
}
