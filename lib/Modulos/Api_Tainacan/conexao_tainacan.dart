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

  static Future getItem(String codigoUrl) async {
    try {
      List listaConteudo = [];

      Uri url = Uri.parse(codigoUrl);
      http.Response resposta = await http.get(url);

      final decode = jsonDecode(resposta.body);
      final idColetion = decode['collection_id'];
      listaConteudo.add(decode['title']);
      listaConteudo.add(decode['description']);

      int idItem = decode['id'];

      final thumbnails =
          'http://testesmuhna.x10.mx/wp-json/tainacan/v2/collection/$idColetion/items/?&exposer=json-flat&id=$idItem';

      Uri url_thumb = Uri.parse(thumbnails);
      http.Response resposta_thumb = await http.get(url_thumb);

      final decode_thumb = jsonDecode(resposta.body);

      print(decode_thumb['items']['0']['id']);

      // decode['metadata']['reino']['value'];
      // decode['metadata']['filo']['value'];
      // decode['metadata']['classe']['value'];
      // decode['metadata']['superordem']['value'];
      // decode['metadata']['subclasse']['value'];
      // decode['metadata']['orde']['value'];

      // decode['metadata']['reino-2']['value'];
      // decode['metadata']['filo-2']['value'];
      // decode['metadata']['inflaclasse']['value'];
      // decode['metadata']['classe-2']['value'];
      // decode['metadata']['superordem-2']['value'];
      // decode['metadata']['ornde']['value'];
      // decode['metadata']['familia']['value'];
      // decode['metadata']['genero']['value'];
      // decode['metadata']['especie']['value'];
      // decode['metadata']['ornde']['value'];

      // String codigoImagens = '$codigoUrl/attachments';
      // print(codigoImagens);
      // Uri urlImagen = Uri.parse(codigoImagens);
      // final respostaImagens = await http.get(urlImagen);

      // final data = json.decode(respostaImagens.body);

      // for (int i = 0; i < data.length; i++) {
      //   listaConteudo.add(data[i]['url']);
      // }
    } catch (e) {
      return null;
    }
  }
}
