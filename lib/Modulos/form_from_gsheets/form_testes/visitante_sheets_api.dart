import 'package:gsheets/gsheets.dart';
import 'package:muhna/Modulos/form_from_gsheets/form_testes/visitante_model.dart';

import 'package:muhna/Variaveis_Privadas/chaves_ocultas.dart';

class VisitanteSheetsApi {
  static getCredenciais() {
    try {
      const credentials = Chaves.credentials;
      return credentials;
    } catch (e) {
      print("Errou $e");
    }
  }

  static getIdPlanilha() {
    try {
      const spreadSheetId = Chaves.spreadSheetId;
      return spreadSheetId;
    } catch (e) {
      print("Voce errou aqui $e");
    }
  }

// store sheet ID
  static final _spreadSheetId = getIdPlanilha();
  static final _credentials = getCredenciais();

  static googleGheets() {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      final _gsheets = GSheets(_credentials);
      return _gsheets;
    } catch (e) {
      print("olha aqui bobo $e");
    }
  }

  static Worksheet? _visitanteSheet;

  static Future init() async {
    try {
      final gsheets = googleGheets();
      final spreadsheet = await gsheets.spreadsheet(_spreadSheetId);
      _visitanteSheet = await _getWorkSheet(spreadsheet, title: 'Dados');

      final firstRow = VisitanteFields.getFields();
      _visitanteSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('init Error: $e');
    }
  }

  static Future<Worksheet?> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return spreadsheet.worksheetByTitle(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title);
      print("teta: $e");
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_visitanteSheet == null) return;
    try {
      _visitanteSheet!.values.map.appendRows(rowList);
    } catch (e) {
      print("Aqui: $e");
    }
  }

  static Future<bool> isonline() async {
    if (_visitanteSheet == null) return false;

    try {
      final lastRow = await _visitanteSheet!.values.lastRow();
      lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
      return true;
    } catch (e) {
      print("erro aqui $e");
      return false;
    }
  }
}
