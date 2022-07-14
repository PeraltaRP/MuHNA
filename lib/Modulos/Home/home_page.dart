import 'package:flutter/material.dart';

import 'package:muhna/Shared/Navigator/botao_visita.dart';
import 'package:muhna/Shared/Themes/app_colors.dart';
import 'package:muhna/Shared/Themes/app_images.dart';
import 'package:muhna/Shared/Themes/app_text_styles.dart';

import '../../Shared/Navigator/botao_chekin.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                      onTap: () => Navigator.pushNamed(context, "/infoScan"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: BotaoChekin(
                      onTap: () => Navigator.pushNamed(context, "/formulario"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
