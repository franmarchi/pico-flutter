class VendaDia {
  String _data = "";
  double _bruto = 0;
  double _desconto = 0;
  double _total = 0;

  VendaDia();

  String get data {
    return _data;
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

  set data(String data) {
    this._data = data;
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

  formatarData(data) {
    List dataFormatada = data.split("-");
    String ano = dataFormatada[0];
    String mes = dataFormatada[1];
    String dia = dataFormatada[2];

    String _data = dia + "/" + mes + "/" + ano;

    return _data;
  }

  VendaDia.fromMap(Map retorno) {
    this.bruto = double.parse(retorno["Bruto"]);
    this.data = formatarData(retorno["data"]);
    this.desconto = double.parse(retorno["Desconto"]);
    this.total = double.parse(retorno["Total"]);
  }
}
