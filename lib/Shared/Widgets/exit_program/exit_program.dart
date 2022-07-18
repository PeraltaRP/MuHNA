import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ExitProgram(){
  //  Future.delayed(const Duration(milliseconds: 5000), () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      // });
}