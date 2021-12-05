class ItensBonificados {
  String _nome = "";
  double _quantidade = 0;
  double _total = 0;

  ItensBonificados();

  String get nome {
    return _nome;
  }

  double get quantidade {
    return _quantidade;
  }

  double get total {
    return _total;
  }

  set nome(String nome) {
    this._nome = nome;
  }

  set quantidade(double quantidade) {
    this._quantidade = quantidade;
  }

  set total(double total) {
    this._total = total;
  }

  ItensBonificados.fromMap(Map retorno) {
    this.nome = retorno["nome"] ?? "";
    this.quantidade = retorno["qtd"] ?? "";
    this.total = double.parse(retorno["vlrtotal"]);
  }
}
