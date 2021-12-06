class RelatorioVendasCanceladas {
  String _venda = "";
  String _apelido = "";
  double _subtotal = 0;
  double _desconto = 0;
  String _descp = "";
  double _total = 0;
  String _tipo = "";
  String _descricao = "";
  String _nome = "";

  RelatorioVendasCanceladas();

  String get venda {
    return _venda;
  }

  String get apelido {
    return _apelido;
  }

  double get subtotal {
    return _subtotal;
  }

  double get desconto {
    return _desconto;
  }

  String get descp {
    return _descp;
  }

  double get total {
    return _total;
  }

  String get tipo {
    return _tipo;
  }

  String get descricao {
    return _descricao;
  }

  String get nome {
    return _nome;
  }

  set venda(String venda) {
    this._venda = venda;
  }

  set apelido(String apelido) {
    this._apelido = apelido;
  }

  set subtotal(double subtotal) {
    this._subtotal = subtotal;
  }

  set desconto(double desconto) {
    this._desconto = desconto;
  }

  set descp(String descp) {
    this._descp = descp;
  }

  set total(double total) {
    this._total = total;
  }

  set tipo(String tipo) {
    this._tipo = tipo;
  }

  set descricao(String descricao) {
    this._descricao = descricao;
  }

  set nome(String nome) {
    this._nome = nome;
  }

  RelatorioVendasCanceladas.fromMap(Map retorno) {
    this.venda = retorno["Venda"] ?? "";
    this.apelido = retorno["apelido"] ?? "";
    this.subtotal = double.parse(retorno["subtotal"]);
    this.desconto = double.parse(retorno["desconto"]);
    this.descp = retorno["descp"] ?? "";
    this.total = double.parse(retorno["total"]);
    this.tipo = retorno["tipo"] ?? "";
    this.descricao = retorno["descricao"] ?? "";
    this.nome = retorno["nome"] ?? "";
  }
}
