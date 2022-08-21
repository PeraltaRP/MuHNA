import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:muhna/Variaveis_Privadas/chaves_ocultas.dart';

Future tainacan() async {
  var chavesOcultas = Chaves();
  try {
    var username = chavesOcultas.usuario;   //usuario que ira logar no sistema wordpress
    var password = chavesOcultas.senha;     // senha do usuario cadastrado no wordpress

    var url = chavesOcultas.urlLogin;
    var authorization =
        // ignore: prefer_interpolation_to_compose_strings
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var body = jsonEncode({'username': username, 'password': password});

    try {
      http
          .post(Uri.parse(url),
              headers: {
                "Content-Type": "application/json",
                'Authorization': authorization
              },
              body: body)
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        if (statusCode != 1) {
          print("login realizado com sucesso $statusCode");
          // things worked out!

        }
      });
    } catch (e) {
      print(e);
    }
  } catch (e) {
    print("Site Off Line");
  }
}
