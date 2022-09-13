import 'package:flutter/material.dart';
import 'package:muhna/Modulos/form_from_gsheets/form_gsheets/visitante_sheets_api.dart';
import 'package:muhna/Modulos/form_from_gsheets/form_testes/visitante_sheets_api.dart';

import 'AppWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await VisitanteSheetsApi.init();
 
  runApp( const AppWidget());
}
