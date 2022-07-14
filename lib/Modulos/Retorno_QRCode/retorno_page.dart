import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:muhna/Shared/Themes/app_colors.dart';

import '../../Shared/Themes/app_images.dart';
import '../../Shared/Themes/app_text_styles.dart';

class RetornoQrCodePage extends StatefulWidget {
  const RetornoQrCodePage({Key? key}) : super(key: key);

  @override
  State<RetornoQrCodePage> createState() => _RetornoQrCodePageState();
}

class _RetornoQrCodePageState extends State<RetornoQrCodePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String? url_visita;

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

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text('Url'key: $url_visita),
        ],
      ),
    );
  }
}


class pega_url {

  void onChange(String code) {
    // TODO: implement onChange
  }

}
