class Filiais {
  String _codigo = "";
  String _filial = "";

  Filiais();

  String get codigo {
    return _codigo;
  }

  String get filial {
    return _filial;
  }

  set codigo(String codigo) {
    this._codigo = codigo;
  }

  set filial(String filial) {
    this._filial = filial;
  }

  Filiais.fromMap(Map retorno) {
    this.codigo = retorno["codigo"] ?? "";
    this.filial = retorno["descricao"] ?? "";
  }
}
