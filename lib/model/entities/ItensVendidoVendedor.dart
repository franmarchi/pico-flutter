class ItensVendidoVendedor {
  String _apelido = "";
  String _nome = "";
  double _quantidade = 0;
  double _total = 0;

  ItensVendidoVendedor();

  String get apelido {
    return _apelido;
  }

  String get nome {
    return _nome;
  }

  double get quantidade {
    return _quantidade;
  }

  double get total {
    return _total;
  }

  set apelido(String apelido) {
    this._apelido = apelido;
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

  ItensVendidoVendedor.fromMap(Map retorno) {
    this.apelido = retorno["apelido"] ?? "";
    this.nome = retorno["nome"] ?? "";
    this.quantidade = double.parse(retorno["qtd"]);
    this.total = double.parse(retorno["vlrtotal"]);
  }
}
