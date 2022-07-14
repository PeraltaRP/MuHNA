import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:muhna/Modulos/Retorno_QRCode/retorno_page.dart';
import 'package:muhna/Shared/Navigator/botaoContinuar.dart';
import 'package:muhna/Shared/Themes/app_colors.dart';
import 'package:muhna/Shared/Themes/app_images.dart';
import 'package:muhna/Shared/Themes/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class InforQrCodePage extends StatefulWidget {
  const InforQrCodePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InforQrCodePageState createState() => _InforQrCodePageState();
}

class _InforQrCodePageState extends State<InforQrCodePage> {
  String ticket = '';
  final urlCode = pega_url();
  

  // List<String> tickets = [];

  readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.QR,
    );
    setState(() => ticket = code != '-1' ? code : 'Não validado');
    
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        toolbarHeight: size.height * 0.15,
        title: Row(
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
