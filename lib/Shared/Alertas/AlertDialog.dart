// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:muhna/Shared/Themes/app_text_styles.dart';
import 'package:muhna/Shared/Widgets/exit_program/exit_program.dart';

showConfirmDialog(
  BuildContext context,
  String title,
  String description,
  String confirmBtnTxt,
  String cancelBtnTxt,
  Function onConfirmClicked,
) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text(cancelBtnTxt),
    onPressed: () {
      Navigator.of(context).pop(); // dismiss dialog
    },
  );
  Widget confirmButton = FlatButton(
    child: Text(confirmBtnTxt),
    onPressed: () {
      onConfirmClicked.call();
      Navigator.of(context).pop(); // dismiss dialog
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(description),
    actions: [
      cancelButton,
      confirmButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// dialogo com apenas um botão
showInfoDialog(bool status, BuildContext context, String title,
    String description, String confirmBtnTxt) {
  // set up the buttons

  Widget confirmButton = FlatButton(
    child: Text(
      confirmBtnTxt,
      style: TextStyles.alertbutton,
    ),
    onPressed: () {
      ExitProgram();
      // Navigator.of(context).pop(); // dismiss dialog
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title, style: TextStyles.alert_title),
    content: Text(description, style: TextStyles.alert),
    actions: [
      confirmButton,
    ],
  );

  // alert Form
  Widget confirmButtonForm = FlatButton(
    child: Text(
      confirmBtnTxt,
      style: TextStyles.alertbutton,
    ),
    onPressed: () {
      Navigator.of(context).pop(); // dismiss dialog
    },
  );
  // set up the AlertDialog
  AlertDialog alertForm = AlertDialog(
    title: Text(title, style: TextStyles.alert_title),
    content: Text(description, style: TextStyles.alert),
    actions: [
      confirmButtonForm,
    ],
  );
  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      if (status == true) {
        return alert;
      } else {
        return alertForm;
      }
    },
  );
}
