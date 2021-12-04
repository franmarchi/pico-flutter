class Relatorio {
  String _codigo = "";
  String _descricao = "";
  double _bruto = 0;
  double _desconto = 0;
  double _total = 0;

  Relatorio();

  String get codigo {
    return _codigo;
  }

  String get descricao {
    return _descricao;
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

  set codigo(String codigo) {
    this._codigo = codigo;
  }

  set descricao(String descricao) {
    this._descricao = descricao;
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

  Relatorio.fromMap(Map retorno) {
    this.codigo = retorno["codigo"] ?? "";
    this.descricao = retorno["descricao"] ?? "";
    this.bruto = double.parse(retorno["Bruto"]);
    this.desconto = double.parse(retorno["Desconto"]);
    this.total = double.parse(retorno["Total"]);
  }
}
