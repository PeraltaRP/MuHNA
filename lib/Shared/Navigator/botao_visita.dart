import 'package:flutter/material.dart';
import 'package:muhna/Shared/Themes/app_colors.dart';
import 'package:muhna/Shared/Themes/app_images.dart';
import 'package:muhna/Shared/Themes/app_text_styles.dart';

class BotaoVisita extends StatelessWidget {
  final VoidCallback onTap;
  // final size = MediaQuery.of(context).size;
  const BotaoVisita({Key? key, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 66,
        decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(10),
            border: Border.fromBorderSide(
              BorderSide(
                color: AppColors.primary,
              ),
            )),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.logoMiniScan,
                      width: 50,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 66,
                      width: 1,
                      color: AppColors.primary,
                    )
                  ],
                )),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Começar Visita",
                    style: TextStyles.buttonHome,
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
