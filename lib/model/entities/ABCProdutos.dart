class ABCProdutos {
  String _nome = "";
  String _referencia = "";
  String _und = "";
  double _qtd = 0;
  double _total = 0;
  String _precoMedio = "";
  String _lucratividade = "";

  ABCProdutos();

  String get nome {
    return _nome;
  }

  String get referencia {
    return _referencia;
  }

  String get und {
    return _und;
  }

  double get qtd {
    return _qtd;
  }

  double get total {
    return _total;
  }

  String get precoMedio {
    return _precoMedio;
  }

  String get lucratividade {
    return _lucratividade;
  }

  set nome(String nome) {
    this._nome = nome;
  }

  set referencia(String referencia) {
    this._referencia = referencia;
  }

  set und(String und) {
    this._und = und;
  }

  set qtd(double qtd) {
    this._qtd = qtd;
  }

  set total(double total) {
    this._total = total;
  }

  set precoMedio(String precoMedio) {
    this._precoMedio = precoMedio;
  }

  set lucratividade(String lucratividade) {
    this._lucratividade = lucratividade;
  }

  ABCProdutos.fromMap(Map retorno) {
    this.nome = retorno["nome"] ?? "";
    this.referencia = retorno["referencia"] ?? "";
    this.und = retorno["und"] ?? "";
    this.qtd = double.parse(retorno["qtd"]);
    this.total = double.parse(retorno["Total"]);
    this.precoMedio = retorno["PrecoMedio"] ?? "";
    this.lucratividade = retorno["Lucratividade"] ?? "";
  }
}
