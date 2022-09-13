import 'package:flutter/services.dart';

// ignore: non_constant_identifier_names
ExitProgram(){
  //  Future.delayed(const Duration(milliseconds: 5000), () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      // });
}