import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class LocalizacaoController {
  Future<String> posicaoAtual() async {
    LocationPermission permissao;

    bool ativado = await Geolocator.isLocationServiceEnabled();
    if (!ativado) {
      return Future.error('Por favor, habilite a localização no smartphone');
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso à localização');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error('Você precisa autorizar o acesso à localização');
    }
    Position posicao = await Geolocator.getCurrentPosition();
    double latitude = posicao.latitude;
    double longitude = posicao.longitude;
    Future<String> local_Valido = validaLocalizacao(latitude, longitude);

    return local_Valido;
  }

  Future<String> validaLocalizacao(
    double latitude_user, double longitude_user) async {
    double xmininolocalValido = -15.88009;
    double xmaximolocalValido = -15.87894;

    double yminimolocalValido = -52.30838;
    double ymaxinolocalValido = -52.30764;


    double latitude = latitude_user;
    double longitude = longitude_user;

    if (latitude >= xmininolocalValido &&
        latitude <= xmaximolocalValido &&
        longitude >= yminimolocalValido &&
        longitude <= ymaxinolocalValido) {
      return ("sim");
    } else {
      return ("nao");
    }
    
  }
}
