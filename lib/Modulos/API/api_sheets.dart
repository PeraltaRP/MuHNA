// import 'package:flutter/cupertino.dart';
// import 'package:gsheets/gsheets.dart';
// import 'package:muhna/model/visitante_fields.dart';

// class VisistanteSheetsApi {
//   static const _credentials = r'''{
//   "type": "service_account",
//   "project_id": "registrovisitantes",
//   "private_key_id": "a4e44d218670ebd6ff64b94932e208fc5fbcd7e7",
//   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDBdKbLowQlF1QT\nXz34O7VvCTfc2+l9/Aed8wJtyKOEqbPQk98QP0ejHToz/aCc2EmnAPVsUIbV2OT7\no0cPcPHZZABhBrj5v/9f+sOIDmGNfwR6HyXdJuerjrMzUBk6pcgmafyLv4Pc+48l\nTKXbRY4ArV1sPJjjunAYmq/OtWJ6ejH9WtoBc3hJXu6l3zczQ6IS3wjdl7Ef81wV\nF5r+kHRiC+VTSodfZqcFt0Fb4ownkc6/vdbg8LUv0QD8KizJPCyHOYqTqo/L6DBP\nqoY420dnkHD0aRzMF+QVbHLa0KOosB6819ickEUC5JOBg2erJD+6vrGLTYvRK6v1\n/XP4beX/AgMBAAECggEAK8rPzS4wTIMs5Zu8R/qgNiv0iNsBTqMkSEWP6bEvDuNp\nkJBAwQlKGqsNl2JVHtw5RARMCkJqW3NXVn1eIykynj7sdQpUCjlDwoLeC2kR/Tlh\nFpIBfMAHVocdmsKJi4Smu8dnQ21NmNMbUtq4etwSaqXUDaHkDD0SjgdKP/VAfy/P\nt3WueAGnXnFPTFGXH2i3pEzCQ4D7bSxvEY0SGxcYzBtjW0HpyIJo8pQFdSIEfEO2\nApaNgIE2nH25hggDy+wmw3H8Z3G486vIjqiXb7ls5b+evlbTISjU2nfWYcl3eKnW\npWkgPgq92iuYNxRZuvFBNI+52MBJPDEaqKUFCUJ+EQKBgQD6Zo+P4Zyw13yqOeg2\nKoT0QCDWWwFDH0TZ9whwcFyIsdj+0TCb+4F1TwkZa5AJHVJK28BTLjFZk3wL1ly3\ndKnCkQ/7ybneqha8QtEWoRhF6jpqP1xUuP8agfID8/ewt1zuH0CVOBJU49xJFMcP\nH9KNnZoy/yjDV3XQP8yBg0TeDwKBgQDFyBrHtalJOZDtak00+XV4TcDe8aAIp/IR\n0PUba1VxM8w8roNndiYRikgI8cocSyKzpCI7xBg3E45F2WAgu/8Aiyd2ugcv0XQP\nd22Krdw9kCLT+/QJgCnYOtTUs2kDnBEaYrwi8J5qWKjOoLw6dk07iM/dQ/fz1wQO\nU90s2MlpEQKBgCJxrzfUihBNZAmqc4XX7XgHxjyWQiMwjvEIqTGGU0Q+aqIKtowO\nWa2AVLkZcbO/Q82mUtteVE2FGyApuZFGy/9GoxM4mYfGj+APtOFPAZ7EbIqm8pV4\n6SaFT3w5uA2n+3GJ/QFJuEPTID8xS3yKHRV743U2Yi4UvtEJpaD/JJ8DAoGBALg1\nEnQ1BvFzUz88haI0QSuGR3+dze6h9TyQwOkDw/WGR8+wviRrjzNA9qyV/ibx9+UW\nlufRULhjV1xJBFYYon1wHZZf1ve7ffw1wGmsWndgOn/zpyv+GXsR+E4Ot10sS2Wm\n1hE4yGLGJpska4uLyY0MdIVhm5uZBGcPxuzREG3xAoGBALl1CYagi0HMulOjT80Y\nP18pEfyQfidt3fBTjge+K6Vwz5eBcG6qemEXRl7rcbQuwyuipUA1OuzKxNl/OV4B\nQNtdA4nU4nQo6SVbbupq+gllMuxIEBJcyi4hxSTtI4hmdxER+No8SO3kp5tNplD+\nXZaeM59ABsS5kZajETvNbFjN\n-----END PRIVATE KEY-----\n",
//   "client_email": "visitantes@registrovisitantes.iam.gserviceaccount.com",
//   "client_id": "102398253645034275561",
//   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//   "token_uri": "https://oauth2.googleapis.com/token",
//   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/visitantes%40registrovisitantes.iam.gserviceaccount.com"
// }''';
//   static const _spreadsheetId = '1gdXyMyqXAZRkoJVUIE0N3Du1fAAV52hDrOUXiCTr8eg';

//   // iniciando google sheets
//   // ignore: non_constant_identifier_names
//   static Worksheet? _VisitanteSheet;

//   static final _gsheets = GSheets(_spreadsheetId);

//   static Future init() async {
//     try {
//       final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
//       _VisitanteSheet = await _getWorkSheet(spreadsheet, title: "Visitantes");
//       final firstRow = VisitanteFields.getFields();
//       _VisitanteSheet!.values.insertRow(1, firstRow);
//     } catch (e) {
//       print("erro:$e");
//     }
//   }

//   static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
//       {required String title}) async {
//     try {
//       return await spreadsheet.addWorksheet(title);
//     } catch (e) {
//       return spreadsheet.worksheetByTitle(title)!;
//     }
//   }

//   static  insert(List<Map<String, dynamic>> rowList) async {
//     // if (_VisitanteSheet != null) {
//     print(rowList[0]);
//     _VisitanteSheet?.values.map.appendRows(rowList);
//     // }
//   }
// }
