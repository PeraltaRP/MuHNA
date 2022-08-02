import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:muhna/model/visitante_dados.dart';


class VisitanteController {
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL
  static const String URL = "https://script.google.com/macros/s/AKfycbykQ2egW5fkKlNvmfpxpJa5PoRTaL4w40aC9AKJhawCNnPZlpB9hJwJD7FVjnFkD5_d4g/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  VisitanteController(this.callback);

  void submitForm(VisitanteDados feedbackForm) async{
    try{
      await http.get(URL + feedbackForm.toParams()).then(
          (response){
            callback(convert.jsonDecode(response.body)['status']);
          });
    } catch(e){
      print(e);
    }
  }
}

// import 'package:muhna/model/visitante_dados.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;



// class VisitanteController {
//   final void Function(String) callback;

//   var url =
//       "https://script.google.com/macros/s/AKfycbykQ2egW5fkKlNvmfpxpJa5PoRTaL4w40aC9AKJhawCNnPZlpB9hJwJD7FVjnFkD5_d4g/exec";

//   static const STATUS_SUCCESS = "SUCCESS";
//   VisitanteController(this.callback);

//   void submitForm(VisitanteDados visitante_dados) async {
//     url += visitante_dados.toParams();
//     Uri uri = Uri.parse(url);
//     try {
//       await http.get(uri).then((response) {
//         callback(convert.jsonDecode(response.body)['status']);
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
// }
