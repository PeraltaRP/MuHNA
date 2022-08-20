import 'package:flutter/material.dart';

import 'AppWidget.dart';
import 'Modulos/form_from_gsheets/visitante_sheets_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
  await VisitanteSheetsApi.init();
  }catch(e){
    print("estamos aqui $e");
  }
  runApp( const AppWidget());
}
