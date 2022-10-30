// ignore: file_names
import 'package:flutter/material.dart';

import 'package:muhna/Shared/Themes/app_colors.dart';
import 'package:muhna/Shared/Themes/app_text_styles.dart';

class BotaoContinuar extends StatelessWidget {
  final VoidCallback onTap;
  const BotaoContinuar({Key? key, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(5),
            border: Border.fromBorderSide(BorderSide(color: AppColors.stroke))),
        child: Row(children: [
          Expanded(
            //define configuraçoes do botão
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Continuar",
                  style: TextStyles.buttonPrimary,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
