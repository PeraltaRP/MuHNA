
import 'package:flutter/material.dart';
import 'package:muhna/Modulos/Formulario_Presenca/formulario.dart';
import 'package:muhna/Modulos/Home/home_page.dart';

import 'package:muhna/Modulos/Informe_QrCode/info_QrCode.dart';
import 'package:muhna/Modulos/Splash/splash_page.dart';
import 'package:muhna/Shared/Themes/app_colors.dart';

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
        "/formulario": (context) => FormularioPage(),
        "/infoScan": (context) => const InforQrCodePage(),
        // "/local":(context) => PostosPage(),
        // "/resposta": (context) => const RespostaPage(),
      },
    );
  }
}
