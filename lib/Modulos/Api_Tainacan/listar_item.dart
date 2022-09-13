import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:muhna/Modulos/Api_Tainacan/conexao_tainacan.dart';
import 'package:muhna/Modulos/Home/home_page.dart';
import 'package:muhna/Modulos/Informe_QrCode/info_QrCode.dart';
import 'package:muhna/Modulos/Video_Player/video_player.dart';
import 'package:muhna/Shared/Alertas/AlertDialog.dart';
import 'package:muhna/Shared/Themes/app_colors.dart';
import 'package:muhna/Shared/Themes/app_images.dart';
import 'package:muhna/Shared/Themes/app_text_styles.dart';
import 'package:muhna/Shared/Widgets/set_buttons/set_label_buttons.dart';
import 'package:video_player/video_player.dart';

class ListarItemTainacan2 extends StatefulWidget {
  String codigoUrl;
  ListarItemTainacan2({required this.codigoUrl});

  @override
  State<ListarItemTainacan2> createState() => _ListarItemTainacan2State();
}

class _ListarItemTainacan2State extends State<ListarItemTainacan2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final RelativeRectTween _relativeRectTween = RelativeRectTween(
    begin: const RelativeRect.fromLTRB(24, 24, 24, 200),
    end: const RelativeRect.fromLTRB(24, 24, 24, 250),
  );

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      body: FutureBuilder(
        future: ApiTainacan.getItem(widget.codigoUrl.toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SizedBox(
                      width: 90,
                      height: 90,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF926F6C)),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Carregando Resultado...'),
                ),
              ],
            );
          } else {
            if (snapshot.data == null) {
              return Stack(
                children: [
                  PositionedTransition(
                    rect: _relativeRectTween.animate(_controller),
                    child: Image.asset(AppImages.brain),
                  ),
                  Positioned(
                    top: 150,
                    bottom: 0,
                    left: 24,
                    right: 24,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          '404',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 50,
                              letterSpacing: 2,
                              color: Color(0xff2f3640),
                              fontFamily: 'Anton',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Me Desculpe, mas estamos com o servidor Off line no momento',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xff2f3640),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              if (snapshot.data[0].assetDocumento.toString().contains(".mp4") ||
                  snapshot.data[0].assetDocumento.toString().contains(".mp3")) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const SizedBox(
                        //Use of SizedBox
                        height: 30,
                      ),
                      Text(snapshot.data[0].titulo,
                          style: TextStyles.tituloqrcode),
                      const SizedBox(
                        //Use of SizedBox
                        height: 30,
                      ),
                      Image.network(
                        snapshot.data[0].assetTabnail.toString(),
                        width: size.width * 1,
                        height: size.height * 0.4,
                      ),
                      SizedBox(
                        width: size.width * 0.9,
                        child: Text(snapshot.data[0].descricao,
                            style: TextStyles.descricoqrcode,
                            textAlign: TextAlign.justify),
                      ),
                      const SizedBox(
                        //Use of SizedBox
                        height: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: size.height * 0.5,
                              child: ChewieListItem(
                                  videoPlayerController:
                                      VideoPlayerController.network(snapshot
                                          .data[0].assetDocumento
                                          .toString()),
                                  looping: true))
                        ],
                      )
                    ],
                  ),
                );
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const SizedBox(
                        //Use of SizedBox
                        height: 30,
                      ),
                      Text(snapshot.data[0].titulo,
                          style: TextStyles.tituloqrcode),
                      SizedBox(
                        child: Image.network(
                          snapshot.data[0].assetTabnail.toString(),
                          // width: size.width * 1,
                          height: size.height * 0.4,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.9,
                        child: Text(snapshot.data[0].descricao,
                            style: TextStyles.descricoqrcode,
                            textAlign: TextAlign.justify),
                      ),
                      const SizedBox(
                        //Use of SizedBox
                        height: 30,
                      ),
                      Image.network(snapshot.data[0].assetDocumento.toString()),
                      const SizedBox(
                        //Use of SizedBox
                        height: 90,
                      ),
                    ],
                  ),
                );
              }
            }
          }
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 1, thickness: 1, color: AppColors.stroke),
          SetLabelButtons(
            enableSecondaryColor: true,
            labelPrimary: 'Ler Novamente',
            onTapPrimary: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InforQrCodePage()),
                  ModalRoute.withName("/Home"));
            },
            labelSecondary: 'Finalizar Leitura',
            onTapSecondary: () async {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  ModalRoute.withName("/Home"));
            },
          ),
        ],
      ),
    );
  }
}
