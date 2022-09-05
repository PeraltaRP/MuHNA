import 'package:flutter/material.dart';
import 'package:muhna/Modulos/Home/home_page.dart';
import 'package:muhna/Modulos/Informe_QrCode/info_QrCode.dart';
import 'package:muhna/Modulos/Splash/splash_page.dart';
import 'package:muhna/Modulos/form_from_gsheets/form_gsheets.dart';
import 'package:muhna/Shared/Themes/app_colors.dart';

import 'Modulos/Retorno_QRCode/retorno_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muhna',
      theme: ThemeData(primaryColor: AppColors.primary),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => const SplashPage(),
        "/home": (context) => const HomePage(),
        "/infoScan": (context) => const InforQrCodePage(),
        "/formsheetslocal":(context) => const Form_Gsheet_Page(),
        // '/exibQrCode': (context) =>  RetornoQrCodePage(codigoUrl: ''),
        // "/local":(context) => PostosPage(),
        // "/resposta": (context) => const RespostaPage(),
      },
    );
  }
}
