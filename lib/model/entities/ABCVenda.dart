class ABCVenda {
  String _apelido = "";
  double _subtotal = 0;
  double _desconto = 0;
  String _descontop = "";
  double _total = 0;

  ABCVenda();

  String get apelido {
    return _apelido;
  }

  double get subtotal {
    return _subtotal;
  }

  double get desconto {
    return _desconto;
  }

  String get descontop {
    return _descontop;
  }

  double get total {
    return _total;
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

  set descontop(String descontop) {
    this._descontop = descontop;
  }

  set total(double total) {
    this._total = total;
  }

  ABCVenda.fromMap(Map retorno) {
    this.apelido = retorno["apelido"] ?? "";
    this.subtotal = double.parse(retorno["subtotal"]);
    this.desconto = double.parse(retorno["desconto"]);
    this.descontop = retorno["descontop"] ?? "0.0";
    this.total = double.parse(retorno["total"]);
  }
}
