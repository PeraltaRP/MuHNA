import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

Future<String> isonline() async {
  return "online";
}

Future<bool> cadastro(
    String? nome, String? instituicao, String? cidade, String? idade) async {
  List<String> cidadeEstado = cidade!.split(" - ");

  try {
    var urlServidor = Uri.parse("http://192.168.0.6:8000/api/v1/visitas/");
    var cabecalho = {'Content-Type': 'application/json'};

    List<String> cidadeEstado = cidade.split(" - ");

    // ignore: non_constant_identifier_names
    var VisitanteJson = jsonEncode(
    //   {
    //   "nome": "codasdasd",
    //   "instituicao": "Cathasdedral",
    //   "cidade": "Belo Horiasdazonte",
    //   "estado": "MG",
    //   "idade": "33"
    // }

        {
          "nome": nome,
          "instituicao": instituicao,
          "cidade": cidadeEstado[0],
          "estado": cidadeEstado[1],
          "idade": "0"
        }
        );
    final response =
        await http.post(urlServidor, headers: cabecalho, body: VisitanteJson);
    
    // ignore: unrelated_type_equality_checks
    if (response.statusCode >=200 && response.statusCode <= 299) {
      return true;
    }
    return false;
  } catch (e) {
    print(e);
    return false;
  }
}
