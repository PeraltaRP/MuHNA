import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:muhna/Modulos/Api_Tainacan/item_model.dart';

class ApiTainacan {
  static String validaLink(String codigoUrl) {
    if (codigoUrl.contains("tainacan")) {
      List<String> linkParse = codigoUrl.split("&_");
      return linkParse[0];
    } else {
      return "link invalido";
    }
  }

  static Future<List<ItemScanneado>?> getItem(String codigoUrl) async {
    try {
      Uri url = Uri.parse(codigoUrl);

      http.Response resposta = await http.get(url);

      Map<String, dynamic> map = json.decode(resposta.body);
      List<dynamic> data = map["items"];
      List<dynamic> listatunb = map['items'];
      List<ItemScanneado> listaItem = [];

      for (var element in data) {
        // ignore: non_constant_identifier_names
        Map Item = element;
        // ignore: non_constant_identifier_names
        Map Data = Item['data'];
        // ignore: non_constant_identifier_names
        Map AssetDocumento = Item['document'];

        var novoTitulo = verificaInclementotitulo(Data, 0, "titulo");
        var novadescricao = verificaInclementodescricao(Data, 0, "descricao");
        String tumbnail = verificaTunbnail(listatunb);
        // print("object ${tumbnail}");

        // ignore: non_constant_identifier_names
        Map Titulo = Data[novoTitulo];
        // ignore: non_constant_identifier_names
        Map Descricao = Data[novadescricao];

        ItemScanneado novoItem = ItemScanneado(
          int.parse(Item['id'].toString()),
          Titulo['value'],
          Descricao['value'],
          AssetDocumento['value'],
          tumbnail,
        );

        listaItem.add(novoItem);
      }
      return listaItem;
    } catch (e) {
      return null;
    }
  }

  // ignore: non_constant_identifier_names
  static verificaInclementotitulo(Map Data, int i, String titulo) {
    if (Data[titulo] == null) {
      titulo = "titulo" "-" "$i";

      i++;
      return verificaInclementotitulo(Data, i, titulo);
    }
    return titulo;
  }

  // ignore: non_constant_identifier_names
  static verificaInclementodescricao(Map Data, int i, String descricao) {
    if (Data[descricao] == null) {
      descricao = "descricao" "-" "$i";

      i++;
      return verificaInclementodescricao(Data, i, descricao);
    }
    return descricao;
  }

  static verificaTunbnail(List<dynamic> listatunb) {
    String t = "a";
    for (var element in listatunb) {
      Map t2 = element;
      List<dynamic> t3 = t2['thumbnail'];
      t = t3[0];
      // print(t3[0]);
    }
    return t;
  }
}
