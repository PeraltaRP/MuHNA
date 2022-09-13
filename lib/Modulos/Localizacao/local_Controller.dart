// ignore: file_names
// ignore_for_file: file_names

import 'package:geolocator/geolocator.dart';

class LocalizacaoController {
  Future<bool> posicaoAtual() async {
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
    Future<bool> localValido = validaLocalizacao(latitude, longitude);
    print("local valido ${localValido}");

    return localValido;
  }

  Future<bool> validaLocalizacao(
      double latitudeUser, double longitudeUser) async {
    // localização programador
    double xmininolocalValido = -15.88009;
    double xmaximolocalValido = -15.87894;

    double yminimolocalValido = -52.30838;
    double ymaxinolocalValido = -52.30764;

    // localização UFMT
    // double xmininolocalValido = -15877162;
    // double xmaximolocalValido = -15875073;

    // double yminimolocalValido = -52314718;
    // double ymaxinolocalValido = -52311671;

    double latitude = latitudeUser;
    double longitude = longitudeUser;

    if (latitude >= xmininolocalValido &&
        latitude <= xmaximolocalValido &&
        longitude >= yminimolocalValido &&
        longitude <= ymaxinolocalValido) {
      return (true);
    } else {
      return (true);
    }
  }
}
