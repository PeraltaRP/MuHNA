import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muhna/Api_Tainacan/api_provider.dart';
import 'package:muhna/Modulos/form_from_gsheets/visitante_sheets_api.dart';

import 'package:muhna/Shared/Navigator/botao_visita.dart';
import 'package:muhna/Shared/Themes/app_colors.dart';
import 'package:muhna/Shared/Themes/app_images.dart';
import 'package:muhna/Shared/Themes/app_text_styles.dart';

import '../../Shared/Alertas/AlertDialog.dart';
import '../../Shared/Navigator/botao_chekin.dart';
import '../Localizacao/local_Controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool localValido;
  late bool isonline;

  // Future<void> getlocal() async {
  //  bool local = await LocalizacaoController().posicaoAtual();
  //   setState(() => localValido = local);
  // }

  Future<void> statusServidor() async {
    bool servidor = await VisitanteSheetsApi.isonline();
    tainacan();
    setState(() => isonline = servidor);
  }

  @override
  void initState() {
    // getlocal();
    // login_api();
    statusServidor();

    localValido = true;
    isonline = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        toolbarHeight: size.height * 0.15,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.logoTamandua,
                  height: size.height * 0.08,
                ),
                Container(
                  padding: const EdgeInsets.all(11.0),
                  child: Text(
                    "MuHNA",
                    style: (TextStyles.teste),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  "Museu de História Natural do Araguaia",
                  style: (TextStyles.subtitlelogo),
                ),
              ],
            ),
          ],
        ),
      ),
      // inicio do cabeçanho
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              top: size.width * 0.1,
              bottom: 1,
              left: size.height * 0.01,
              right: size.height * 0.01,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: BotaoVisita(
                      onTap: () {
                        Navigator.pushNamed(context, "/infoScan");
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: BotaoChekin(onTap: () {
                      verificaServidorCadastroVisitante(isonline, localValido);
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  verificainicializacao(bool localValido) {
    if (localValido == "") {
      return true;
    } else {
      showInfoDialog(
        false,
        context,
        "Fora dos Limites de Atuação",
        "Poxa :( Infelizmente o app só funciona dentro da UFMT-Araguaia",
        "OK",
      );
    }
    return false;
  }

  // ignore: non_constant_identifier_names
  verificaServidorCadastroVisitante(bool isonline, bool LocalValido) async {
    if (isonline == true) {
      bool local = verificainicializacao(localValido);
      if (localValido == true) {
        Navigator.pushNamed(context, "/formsheetslocal");
      }
    } else {
      showInfoDialog(
        false,
        context,
        "Servidor Off Line",
        "Não é você! Sou eu. Eu que estou Offline ;(",
        "ok",
      );

      bool verificaNovamente = await VisitanteSheetsApi.isonline();

      verificaServidorCadastroVisitante(verificaNovamente, LocalValido);
    }
  }
}
