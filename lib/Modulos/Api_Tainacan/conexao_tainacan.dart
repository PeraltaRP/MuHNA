import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:muhna/Modulos/Api_Tainacan/item_model.dart';

class ApiTainacan {
  static String validaLink(String codigoUrl) {
    if (codigoUrl.contains("tainacan")) {
      return codigoUrl;
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

      
      if (decode['metadata']['reino']['value'] != null) {
        listaConteudo.add(decode['metadata']['reino']['value']);
      }
      // if (decode['metadata']['reino-2']['value'] != null) {
      //   listaConteudo.add(decode['metadata']['reino-2']['value']);
      // }
      
      if (decode['metadata']['filo']['value'] != null) {
        listaConteudo.add(decode['metadata']['filo']['value']);
      }
      // if (decode['metadata']['filo-2']['value'] != null) {
      //   listaConteudo.add(decode['metadata']['filo-2']['value']);
      // }
      if (decode['metadata']['classe']['value'] != null) {
        listaConteudo.add(decode['metadata']['classe']['value']);
      }
      // if (decode['metadata']['classe-2']['value'] != null) {
      //   listaConteudo.add(decode['metadata']['classe-2']['value']);
      // }
      if (decode['metadata']['superordem']['value'] != null) {
        listaConteudo.add(decode['metadata']['superordem']['value']);
      }
      // if (decode['metadata']['superordem-2']['value'] != null) {
      //   listaConteudo.add(decode['metadata']['superordem-2']['value']);
      // }
      if (decode['metadata']['subclasse']['value'] != null) {
        listaConteudo.add(decode['metadata']['subclasse']['value']);
      }
      if (decode['metadata']['orde']['value'] != null) {
        listaConteudo.add(decode['metadata']['orde']['value']);
      }
      // if (decode['metadata']['inflaclasse']['value'] != null) {
      //   listaConteudo.add(decode['metadata']['inflaclasse']['value']);
      // }
      // if (decode['metadata']['ornde']['value'] != null) {
      //   listaConteudo.add(decode['metadata']['ornde']['value']);
      // }
      // if (decode['metadata']['familia']['value'] != null) {
      //   listaConteudo.add(decode['metadata']['familia']['value']);
      // }
      // if (decode['metadata']['genero']['value'] != null) {
      //   listaConteudo.add(decode['metadata']['genero']['value']);
      // }
      // if (decode['metadata']['especie']['value'] != null) {
      //   listaConteudo.add(decode['metadata']['especie']['value']);
      // }
      

      //função attachement Carrega todas as imagens menos a tumbnail
      String codigoImagens = '$codigoUrl/attachments';
      Uri urlImagen = Uri.parse(codigoImagens);
      final respostaImagens = await http.get(urlImagen);

      final data = json.decode(respostaImagens.body);

      for (int i = 0; i < data.length; i++) {
        listaConteudo.add(data[i]['url']);
      }

      // fim attachement

      // função carrega tumbnail
      int idItem = decode['id'];
      String tunb;
      final thumbnails =
          'http://testesmuhna.x10.mx/wp-json/tainacan/v2/collection/$idColetion/items/?&exposer=json-flat&id=$idItem';
      Uri url_thumb = Uri.parse(thumbnails);
      http.Response resposta_thumb = await http.get(url_thumb);
      Map<String, dynamic> map = json.decode(resposta_thumb.body);
      List<dynamic> listatunb = map['items'];
      for (var element in listatunb) {
        Map Item = element;
        List thumbnail = Item['thumbnail'];
        tunb = thumbnail[0];
        listaConteudo.add(tunb);
      }
      // fim da thumbanil

      return listaConteudo;
      // for (int i = 0; i < listaConteudo.length; i++) {
      //   print(listaConteudo[i]);
      // }
    } catch (e) {
      return null;
    }
  }
}
