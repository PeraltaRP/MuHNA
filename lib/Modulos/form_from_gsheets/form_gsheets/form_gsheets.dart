// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:muhna/Modulos/form_from_gsheets/form_testes/visitante_model.dart';
// import 'package:muhna/Modulos/form_from_gsheets/form_testes/visitante_sheets_api.dart';
// import 'package:muhna/Shared/Alertas/AlertDialog.dart';
// import 'package:muhna/Shared/Themes/app_colors.dart';
// import 'package:muhna/Shared/Themes/app_images.dart';
// import 'package:muhna/Shared/Themes/app_text_styles.dart';
// import 'package:muhna/Shared/Widgets/input_text/input_text_widget.dart';



// // ignore: camel_case_types
// class Form_Gsheet_Page extends StatefulWidget {
//   const Form_Gsheet_Page({Key? key}) : super(key: key);

//   @override
//   State<Form_Gsheet_Page> createState() => _Form_Gsheet_PageState();
// }

// // ignore: camel_case_types
// class _Form_Gsheet_PageState extends State<Form_Gsheet_Page> {
//   final _formKey = GlobalKey<FormState>();
//   // vaiaveis para o cadastro do visitante
//   final _nomeController = TextEditingController();
//   final _instituicaoController = TextEditingController();
//   String? _cidadeController;
//   final _idadeController = TextEditingController();
//   final _feedback = TextEditingController();

//   // fim das variaveis de cadastro do visitante
//   // inicio do autocomplete
//   bool isLoading = false;
//   late List<String> autoCompleteCidades;
//   late TextEditingController controller;

//   Future constroiAutoComplete() async {
//     setState(() {
//       isLoading = true;
//     });
//     final String cidadeJson =
//         await rootBundle.loadString("assets/cidades/cidades.json");

//     final List<dynamic> json = jsonDecode(cidadeJson);

//     final List<String> jsonStringCidades = json.cast<String>();

//     setState(() {
//       isLoading = false;
//       autoCompleteCidades = jsonStringCidades;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     constroiAutoComplete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     initializeDateFormatting('pt_BR', null);
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: AppColors.primary,
//         toolbarHeight: size.height * 0.15,
//         title: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   AppImages.logoTamandua,
//                   height: size.height * 0.08,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(11.0),
//                   child: Text(
//                     "MuHNA de Historia Natural do Araguaia",
//                     style: (TextStyles.teste),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               // ignore: prefer_const_literals_to_create_immutables
//               children: [
//                 Container(
//                   child: Text(
//                     "Museu de História Natural do Araguaia",
//                     style: (TextStyles.subtitlelogo),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: SizedBox(
//           width: size.width,
//           height: size.height,
//           child: Stack(
//             children: [
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     InputTextWidget(
//                       label: "Nome",
//                       icon: Icons.account_box_outlined,
//                       onChanged: (String nome) {},
//                       // onChanged: (value) => (),
//                       controller: _nomeController,
//                       validator: (nome) {
//                         if (nome == null || nome.isEmpty) {
//                           return 'Este espaço não pode ficar em branco';
//                         }
//                         return null;
//                       },
//                     ),
//                     InputTextWidget(
//                       label: "Instituição",
//                       icon: Icons.account_balance_outlined,
//                       onChanged: (String instituicao) {},
//                       controller: _instituicaoController,
//                       validator: (instituicao) {
//                         if (instituicao == null || instituicao.isEmpty) {
//                           return 'Este espaço não pode ficar em branco';
//                         }
//                         return null;
//                       },
//                     ),
//                     InputTextWidget(
//                       label: "Idade",
//                       icon: Icons.star_border_outlined,
//                       onChanged: (String idade) {},
            
//                       controller: _idadeController,
//                       validator: (idade) {
//                         if (idade == null || idade.isEmpty) {
//                           return 'Este espaço não pode ficar em branco';
//                         }
//                         return null;
//                       },
//                     ),
//                     InputTextWidget(
//                       label: "FeedBack",
//                       icon: Icons.feedback_outlined,
//                       onChanged: (String feedback) {},
//                       controller: _feedback,
//                       validator: (feedback) {
//                         if (feedback == null || feedback.isEmpty) {
//                           return 'Este espaço não pode ficar em branco';
//                         }
//                         return null;
//                       },
//                     ),
//                     isLoading
//                         ? const Center(
//                             child: CircularProgressIndicator(),
//                           )
//                         : Padding(
//                             padding: const EdgeInsets.all(1),
//                             child: Column(
//                               children: [
//                                 Autocomplete(
//                                   optionsBuilder:
//                                       (TextEditingValue textEditingValue) {
//                                     if (textEditingValue.text.isEmpty) {
//                                       return const Iterable<String>.empty();
//                                     } else {
//                                       return autoCompleteCidades.where((word) =>
//                                           word.toLowerCase().contains(
//                                               textEditingValue.text
//                                                   .toLowerCase()));
//                                     }
//                                   },
//                                   onSelected: (value) {
//                                     setState(() {
//                                       _cidadeController = value as String;
//                                     });
//                                   },
//                                   fieldViewBuilder: (context, controller,
//                                       focusNode, onEditingComplete) {
//                                     this.controller = controller;

//                                     return Padding(
//                                       padding:
//                                           const EdgeInsets.only(bottom: 10),
//                                       child: Column(
//                                         children: [
//                                           TextFormField(
//                                             controller: controller,
//                                             focusNode: focusNode,
//                                             style: TextStyles.input,
//                                             decoration: InputDecoration(
//                                                 contentPadding: EdgeInsets.zero,
//                                                 labelText: "Cidade - UF",
//                                                 labelStyle: TextStyles.input,
//                                                 icon: Row(
//                                                   mainAxisSize:
//                                                       MainAxisSize.min,
//                                                   children: [
//                                                     Padding(
//                                                       padding: const EdgeInsets
//                                                               .symmetric(
//                                                           horizontal: 18),
//                                                       child: Icon(
//                                                         Icons
//                                                             .location_city_outlined,
//                                                         color:
//                                                             AppColors.primary,
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                       width: 1,
//                                                       height: 48,
//                                                       color: AppColors.stroke,
//                                                     )
//                                                   ],
//                                                 ),
//                                                 border: InputBorder.none),
//                                           ),
//                                           Divider(
//                                             height: 1,
//                                             thickness: 1,
//                                             color: AppColors.stroke,
//                                           )
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceAround,
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //     ElevatedButton(
                                //       onPressed: () {
                                //         Navigator.pushNamed(context, '/home');
                                //       },
                                //       style: ElevatedButton.styleFrom(
                                //           shape: (RoundedRectangleBorder(
                                //               borderRadius:
                                //                   BorderRadius.circular(10))),
                                //           side: BorderSide(
                                //               color: AppColors.primary),
                                //           primary: AppColors.background,
                                //           onPrimary: AppColors.primary,
                                //           padding: const EdgeInsets.symmetric(
                                //               horizontal: 13),
                                //           textStyle: const TextStyle(
                                //               fontSize: 21,
                                //               fontWeight: FontWeight.bold)),
                                //       child: const Text('Cancelar'),
                                //     ),
                                //     ElevatedButton(
                                //       onPressed: () async {
                                //         FocusScopeNode currentFocus =
                                //             FocusScope.of(context);
                                //         if (_formKey.currentState!.validate()) {
                                //           CadastroVisitante();
                                //           clearText();
                                //         }
                                //       },
                                //       style: ElevatedButton.styleFrom(
                                //           shape: (RoundedRectangleBorder(
                                //               borderRadius:
                                //                   BorderRadius.circular(10))),
                                //           side: BorderSide(
                                //               color: AppColors.primary),
                                //           primary: AppColors.background,
                                //           onPrimary: AppColors.primary,
                                //           padding: const EdgeInsets.symmetric(
                                //               horizontal: 13),
                                //           textStyle: const TextStyle(
                                //               fontSize: 21,
                                //               fontWeight: FontWeight.bold)),
                                //       child: const Text('Cadastrar'),
                                //     ),
                                //   ],
                                // ),
  //                             ],
  //                           ),
  //                         ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

//   void clearText() {
//     _formKey.currentState?.reset();
//     _nomeController.clear();
//     _instituicaoController.clear();
//     _cidadeController = "";
//     _idadeController.clear();
//     _feedback.clear();
//     FocusScope.of(context).requestFocus(FocusNode());
//     WidgetsBinding.instance.addPostFrameCallback((_) => controller.clear());

//    Navigator.pushNamed(context, "/home");
//   }

//   // Fim da criação do autocomplete
//   // ignore: non_constant_identifier_names
//   void CadastroVisitante() async {
//     try {
//       List<String> cidadeEstado = _cidadeController!.split(" - ");

//       DateTime now = DateTime.now();
//       var dateString = DateFormat('dd-MM-yyyy').format(now);

//       final visitante = {
//         VisitanteFields.data: dateString,
//         VisitanteFields.nome: _nomeController.text,
//         // VisitanteFields.instituicao: _instituicaoController.text,
//         VisitanteFields.idade: _idadeController.text,
//         VisitanteFields.feedback: _feedback.text,
//         VisitanteFields.cidade: cidadeEstado[0],
//         VisitanteFields.estado: cidadeEstado[1]
//       };

//       await VisitanteSheetsApi.insert([visitante]);
//       Sucesso();
//     } catch (e) {
//       print("falhou aqui");
//     }
//   }

//   void Sucesso() {
//     showInfoDialog(
//       false,
//       context,
//       ":) Obrigado",
//       "Sua avaliação foi anotada com sucesso",
//       "OK",
//     );
//   }
// }
