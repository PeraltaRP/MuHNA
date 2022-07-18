import 'dart:convert';

import 'package:http/http.dart' as http;

isonline(){

}

Cadastrando_visitante(String? nome, String? instituicao, String? cidade, String? idade) async {
  try {
    var urlServidor = Uri.parse("http://192.168.0.5:8000/api/v1/visitas/");
    var cabecalho = {'Content-Type': 'application/json'};

    List<String> cidadeEstado = cidade!.split(" - ");

    // ignore: non_constant_identifier_names
    var VisitanteJson = jsonEncode({
      "nome": nome,
      "instituicao": instituicao,
      "cidade": cidadeEstado[0],
      "estado": cidadeEstado[1],
      "idade": "0"
    });

    final response = await http.post(urlServidor, headers: cabecalho, body: VisitanteJson);
      if (response.statusCode == 200){
      print('conectad');
      }
      else{
        throw Exception('Erro ao buscar comentários');
      }
    } catch (e) {
      print(e);
    }
  }

