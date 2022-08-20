import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';


Future tainacan() async {
  try {
    var username = 'peraltarp';
    var password = 'pedrorafa';

    var url = 'http://192.168.0.6:10003/wp-json/remote-login/login';
    var authorization =
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

  var response = await http.get(
      Uri.parse(
          "http://localhost:10003/wp-json/tainacan/v2/collection/62/items/?recent=true&id=69&_wpnonce=964633fba0"),
      headers: {"Accept": "application/json"});

var  data = json.decode(response.body)['results'];

  print(data);
}



