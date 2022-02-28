import 'package:flutter/material.dart';

class RelatorioGerencialGraficoVendasporFilial {
  String _nome = "";
  double _total = 0;

  RelatorioGerencialGraficoVendasporFilial();

  String get nome {
    return _nome;
  }

  set nome(String nome) {
    this._nome = nome;
  }

  double get total {
    return _total;
  }

  set total(double total) {
    this._total = total;
  }

  RelatorioGerencialGraficoVendasporFilial.fromMap(Map retorno) {
    this.nome = retorno["nome"] ?? "";
    this.total = double.parse(retorno["Total"] ?? 0);
  }
}
