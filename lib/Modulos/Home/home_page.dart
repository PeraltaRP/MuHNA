import 'dart:async';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:muhna/Shared/Themes/app_colors.dart';
import 'package:muhna/Shared/Themes/app_images.dart';
import 'package:muhna/Shared/Themes/app_text_styles.dart';
import 'package:muhna/Shared/set_buttons/Navigator/botao_chekin.dart';
import 'package:muhna/Shared/set_buttons/Navigator/botao_visita.dart';

import '../../Shared/Alertas/AlertDialog.dart';
import '../Localizacao/local_Controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime timeBackPressed = DateTime.now();
  late bool localValido;
  late Size size = MediaQuery.of(context).size;

  Future<void> getlocal() async {
    bool local = await LocalizacaoController().posicaoAtual();
    setState(() => localValido = local);
  }

  @override
  void initState() {
    localValido = true;
    getlocal();

    super.initState();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          final diference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = diference >= const Duration(seconds: 2);
          timeBackPressed = DateTime.now();

          if (isExitWarning) {
            const message = "Prescione novamente para sair";
            Fluttertoast.showToast(msg: message, fontSize: 18);
            return false;
          } else {
            Fluttertoast.cancel();
            return true;
          }
        },
        child: Scaffold(
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
                          verificainicializacao(localValido);
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  verificainicializacao(bool localValido) {
    if (localValido == true) {
      Navigator.pushNamed(context, "/formTestes");
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
}

      

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: AppColors.primary,
//         toolbarHeight: size.height * 0.15,
//         title: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   AppImages.logoTamandua,
//                   height: size.height * 0.08,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(11.0),
//                   child: Text(
//                     "MuHNA",
//                     style: (TextStyles.teste),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               // ignore: prefer_const_literals_to_create_immutables
//               children: [
//                 Text(
//                   "Museu de História Natural do Araguaia",
//                   style: (TextStyles.subtitlelogo),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       // inicio do cabeçanho
//       body: SizedBox(
//         width: size.width,
//         height: size.height,
//         child: Stack(
//           children: [
//             Positioned(
//               top: size.width * 0.1,
//               bottom: 1,
//               left: size.height * 0.01,
//               right: size.height * 0.01,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(),
//                     child: BotaoVisita(
//                       onTap: () {
//                         Navigator.pushNamed(context, "/infoScan");
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(),
//                     child: BotaoChekin(onTap: () {
//                       verificainicializacao(localValido);
//                     }),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   verificainicializacao(bool localValido) {
//     if (localValido == true) {
//       Navigator.pushNamed(context, "/formTestes");
//     } else {
//       showInfoDialog(
//         false,
//         context,
//         "Fora dos Limites de Atuação",
//         "Poxa :( Infelizmente o app só funciona dentro da UFMT-Araguaia",
//         "OK",
//       );
//     }
//     return false;
//   }
// }
