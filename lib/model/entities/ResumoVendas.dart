class ResumoVendas {
  String _vendedor = "";
  String _produto = "";
  String _qtd = "";
  double _total = 0;
  String _nome = "";
  String _apelido = "";
  double _custo = 0;

  ResumoVendas();

  String get vendedor {
    return _vendedor;
  }

  set vendedor(String vendedor) {
    this._vendedor = vendedor;
  }

  String get produto {
    return _produto;
  }

  set produto(String produto) {
    this._produto = produto;
  }

  String get qtd {
    return _qtd;
  }

  set qtd(String qtd) {
    this._qtd = qtd;
  }

  double get total {
    return _total;
  }

  set total(double total) {
    this._total = total;
  }

  String get nome {
    return _nome;
  }

  set nome(String nome) {
    this._nome = nome;
  }

  String get apelido {
    return _apelido;
  }

  set apelido(String apelido) {
    this._apelido = apelido;
  }

  double get custo {
    return _custo;
  }

  set custo(double custo) {
    this._custo = custo;
  }

  ResumoVendas.fromMap(Map retorno) {
    this.vendedor = retorno["vendedor"] ?? "";
    this.produto = retorno["produto"] ?? "";
    this.qtd = retorno["qtd"] ?? "";
    this.nome = retorno["nome"] ?? "";
    this.total = double.parse(retorno["total"]);
    this.apelido = retorno["apelido"] ?? "";
    this.custo = double.parse(retorno["custo"]);
  }
}
