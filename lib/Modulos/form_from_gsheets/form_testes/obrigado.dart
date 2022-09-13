import 'package:flutter/material.dart';
import 'package:muhna/Modulos/Home/home_page.dart';
import 'package:muhna/Shared/Themes/app_colors.dart';
import 'package:muhna/Shared/Themes/app_images.dart';

import '../../../Shared/Themes/app_text_styles.dart';

class ObrigadoPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ObrigadoPage();

  @override
  // ignore: library_private_types_in_public_api
  _ObrigadoPageState createState() => _ObrigadoPageState();
}

class _ObrigadoPageState extends State<ObrigadoPage>
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
    Future.delayed(const Duration(seconds: 4)).then((_) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        ModalRoute.withName("/obrigado"));

    });
          
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
                  "Museu de Historia Natural do Araguaia",
                  style: (TextStyles.subtitlelogo),
                ),
              ],
            ),
          ],
        ),
      ),
      // backgroundColor: const Color(0xffd8f3dc),
      body: Stack(
        children: [
          PositionedTransition(
            rect: _relativeRectTween.animate(_controller),
            child: Image.asset(AppImages.heart),
          ),
          Positioned(
            top: 180,
            bottom: 0,
            left: 24,
            right: 24,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Obrigado',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 42,
                      letterSpacing: 2,
                      color: Color(0xff2f3640),
                      fontFamily: 'Anton',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Obrigado pela sua paciência e pelo tempo cedido para testar esta aplicação',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff2f3640),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
