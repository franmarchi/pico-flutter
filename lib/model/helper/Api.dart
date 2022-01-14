import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  String url = "http://192.168.0.241:1234/";
  //String url = "http://192.168.15.9:1234/"; //Usar esse ip hoje.
  //String url = "https://vieirasistemas.com.br/painel/script/";
  Api();

  Future<Map> verificarUsuario(String email) async {
    var urlRecuperarDadosUsuario =
        Uri.parse(url + "VerificaLoginUsuarioScript.php");
    http.Response response;
    response = await http.post(
      urlRecuperarDadosUsuario,
      body: {'email': '${email}'},
    );

    Map<dynamic, dynamic> retorno = jsonDecode(response.body);

    return retorno;
  }

  Future<bool> atualizarSenha(String email, String senha) async {
    bool sucesso = false;

    var urlRecuperarDadosUsuario = Uri.parse(url + "UpdateSenhaScript.php");
    http.Response response;
    response = await http.post(
      urlRecuperarDadosUsuario,
      body: {
        'email': '$email',
        'senhaUsuario': '$senha',
      },
    );

    Map<dynamic, dynamic> retorno = jsonDecode(response.body);

    sucesso = retorno["sucesso"];

    return sucesso;
  }

  buscarRelatorio(String dataInicial, String dataFinal, String filial,
      String urlScript) async {
    var urlRecuperarDadosUsuario = Uri.parse(url + urlScript);
    http.Response response;
    response = await http.post(
      urlRecuperarDadosUsuario,
      body: {
        'dataInicio': '$dataInicial',
        'dataFim': '$dataFinal',
        'filial': '$filial'
      },
    );

    String retorno = jsonDecode(jsonEncode(response.body));

    retorno = retorno.replaceAll("}", "}/");
    retorno = retorno.replaceAll("'", "");
    List relatorio = retorno.split("/");

    relatorio.removeLast();

    return relatorio;
  }

  buscarFiliais() async {
    var urlRecuperarDadosUsuario = Uri.parse(url + "FiliaisScript.php");
    http.Response response;
    response = await http.post(
      urlRecuperarDadosUsuario,
      body: {},
    );
    String retorno = jsonDecode(jsonEncode(response.body));

    retorno = retorno.replaceAll("}", "}/");
    retorno = retorno.replaceAll("'", "");
    List filial = retorno.split("/");

    filial.removeLast();

    return filial;
  }

  buscarProduto() async {
    var urlRecuperarDadosUsuario = Uri.parse(url + "GrupoProdutosScript.php");
    http.Response response;
    response = await http.post(
      urlRecuperarDadosUsuario,
      body: {},
    );
    String retorno = jsonDecode(jsonEncode(response.body));
    retorno = retorno.replaceAll("}", "}*");
    retorno = retorno.replaceAll("'", "");
    List filial = retorno.split("*");
    filial.removeLast();

    return filial;
  }

  buscarRelatorioABCProdutos(String dataInicial, String dataFinal,
      String filial, String radio, String produto) async {
    var urlRecuperarDadosUsuario =
        Uri.parse(url + "RelatorioGerencialCurvaABCProdutosScript.php");
    http.Response response;
    response = await http.post(
      urlRecuperarDadosUsuario,
      body: {
        'dataInicio': '$dataInicial',
        'dataFim': '$dataFinal',
        'filial': '$filial',
        'radiobutton': '$radio',
        'produto': '$produto'
      },
    );

    String retorno = jsonDecode(jsonEncode(response.body));

    retorno = retorno.replaceAll("}", "}/");
    retorno = retorno.replaceAll("'", "");
    List relatorio = retorno.split("/");

    relatorio.removeLast();

    return relatorio;
  }

  buscarRelatorioABCVenda(
      String dataInicial, String dataFinal, String filial, String radio) async {
    var urlRecuperarDadosUsuario =
        Uri.parse(url + "RelatorioGerencialCurvaABCVendaFilialScript.php");
    http.Response response;
    response = await http.post(
      urlRecuperarDadosUsuario,
      body: {
        'dataInicio': '$dataInicial',
        'dataFim': '$dataFinal',
        'filial': '$filial',
        'radiobutton': '$radio',
      },
    );

    String retorno = jsonDecode(jsonEncode(response.body));

    retorno = retorno.replaceAll("}", "}/");
    retorno = retorno.replaceAll("'", "");
    List relatorio = retorno.split("/");

    relatorio.removeLast();
    print(relatorio);

    return relatorio;
  }
}
