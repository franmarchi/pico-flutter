class RelatorioVendasCredito {
  String _cod = "";
  String _descricao = "";
  double _bruto = 0;
  double _desconto = 0;
  double _total = 0;

  RelatorioVendasCredito();

  String get cod {
    return _cod;
  }

  double get bruto {
    return _bruto;
  }

  double get desconto {
    return _desconto;
  }

  double get total {
    return _total;
  }

  String get descricao {
    return _descricao;
  }

  set cod(String cod) {
    this._cod = cod;
  }

  set bruto(double bruto) {
    this._bruto = bruto;
  }

  set desconto(double desconto) {
    this._desconto = desconto;
  }

  set total(double total) {
    this._total = total;
  }

  set descricao(String descricao) {
    this._descricao = descricao;
  }

  RelatorioVendasCredito.fromMap(Map retorno) {
    this.cod = retorno["codigo"] ?? "";
    this.descricao = retorno["descricao"] ?? "";
    this.bruto = double.parse(retorno["Bruto"]);
    this.desconto = double.parse(retorno["Desconto"]);
    this.total = double.parse(retorno["Total"]);
  }
}
