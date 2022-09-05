import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:muhna/Modulos/Api_Tainacan/item_model.dart';

class ApiTainacan {
  static String validaLink(String codigoUrl) {
    if (codigoUrl.contains("tainacan")) {
      List<String> linkValidado = codigoUrl.split("&_");
      return (linkValidado[0]);
    } else {
      return "link invalido";
    }
  }

  static Future<List<ItemScanneado>?> getItem(String codigoUrl) async {
    Uri url = Uri.parse(codigoUrl);

    http.Response resposta = await http.get(url);

    Map<String, dynamic> map = json.decode(resposta.body);

    List<dynamic> data = map["items"];
    List<ItemScanneado> listaItem = [];

    data.forEach((element) {
      Map Item = element;
      Map Data = Item['data'];
      Map Titulo = Data['titulo'];
      Map Documento = Item['document'];

      // Map = Item['descricao'];

      // Map Metadados = Item['metadata'];
      // Map Title = Metadados['title'];
      // Map ScientificName = Metadados['nome-cientifico'];

      ItemScanneado novoItem =
          ItemScanneado(int.parse(Item['id'].toString()), Documento['value']

              // int.parse(Item['id'].toString()),
              // Item['title'],
              // Item['description'],
              // Item['document_mimetype'],
              // Item['document_as_html'],
              // ScientificName['value'],
              );
      listaItem.add(novoItem);
    });

    return listaItem;
  }
}
