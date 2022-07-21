import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:muhna/Shared/Themes/app_colors.dart';

import '../../Shared/Themes/app_images.dart';
import '../../Shared/Themes/app_text_styles.dart';

class RetornoQrCodePage extends StatefulWidget {
  late String url;
  RetornoQrCodePage(this.url, {Key? key}) : super(key: key);

  @override
  State<RetornoQrCodePage> createState() => _RetornoQrCodePageState();
}

class _RetornoQrCodePageState extends State<RetornoQrCodePage> {
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
                Container(
                  child: Text(
                    "Museu de História Natural do Araguaia",
                    style: (TextStyles.subtitlelogo),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("A URL PASSADA FOI: ${widget.url}"),
        ],
      ),
    );
  }
}
