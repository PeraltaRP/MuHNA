// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:muhna/Modulos/Api_Tainacan/conexao_tainacan.dart';
import 'package:muhna/Modulos/Api_Tainacan/listar_item.dart';
import 'package:muhna/Shared/Alertas/AlertDialog.dart';
import 'package:muhna/Shared/Themes/app_colors.dart';
import 'package:muhna/Shared/Themes/app_images.dart';
import 'package:muhna/Shared/Themes/app_text_styles.dart';

class InforQrCodePage extends StatefulWidget {
  const InforQrCodePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InforQrCodePageState createState() => _InforQrCodePageState();
}

class _InforQrCodePageState extends State<InforQrCodePage> {
  var ticket = '';

  readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.QR,
    );
    setState(() => ticket = code != '-1' ? code : 'Não validado');
    // ignore: unnecessary_null_comparison
    if (ticket != null) {
      String valido = ApiTainacan.validaLink(ticket);
      if (valido == "link invalido") {
        // ignore: use_build_context_synchronously
        showInfoDialog(
          false,
          context,
          "Link Invalido",
          "Por Favor! Fazer leitura novamente",
          "ok",
        );
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ListarItemTainacan2(codigoUrl: valido)));
      }
    }
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
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.logoScan),
            Padding(
              padding: const EdgeInsets.only(), //modifica posicao do qr code
              child: Text(
                "Aponte para o QR Code e descubra maiores informações",
                style: TextStyles.titleHome,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: readQRCode,
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: BorderSide(color: AppColors.primary),
                    primary: AppColors.background,
                    onPrimary: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 23),
                    textStyle: const TextStyle(
                        fontSize: 21, fontWeight: FontWeight.bold)),
                child: const Text('Continuar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
