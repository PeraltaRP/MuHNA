
import 'package:flutter/material.dart';
import 'package:muhna/Modulos/Home/home_page.dart';
import 'package:muhna/Modulos/Informe_QrCode/info_QrCode.dart';
import 'package:muhna/Modulos/Splash/splash_page.dart';
import 'package:muhna/Modulos/form_from_gsheets/form_testes/form_testes.dart';
import 'package:muhna/Modulos/form_from_gsheets/form_testes/obrigado.dart';
import 'package:muhna/Modulos/form_from_gsheets/form_testes/radio.dart';
import 'package:muhna/Shared/Themes/app_colors.dart';



class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muhna',
      theme: ThemeData(primaryColor: AppColors.primary),
      initialRoute: "/page",
      routes: {
        "/splash": (context) => const SplashPage(),
        "/home": (context) => const HomePage(),
        "/infoScan": (context) => const InforQrCodePage(),
        // "/formsheetslocal": (context) => const Form_Gsheet_Page(),
        "/formTestes": (context) => const Form_Gsheet_Page(),
        "/radio": (context) =>
            radio_page(nome: "0", idade: "0", curso: "0", cidade: "0"),
        "/obrigado": (context) => const ObrigadoPage(),
        "/page":(context) => const InforQrCodePage(),
      },
    );
  }
}
