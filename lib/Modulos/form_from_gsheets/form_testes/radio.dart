import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:muhna/Modulos/Home/home_page.dart';
import 'package:muhna/Modulos/form_from_gsheets/form_testes/obrigado.dart';
import 'package:muhna/Modulos/form_from_gsheets/form_testes/visitante_model.dart';
import 'package:muhna/Modulos/form_from_gsheets/form_testes/visitante_sheets_api.dart';

import 'package:muhna/Shared/Alertas/AlertDialog.dart';

import '../../../Shared/Themes/app_colors.dart';
import '../../../Shared/Themes/app_images.dart';
import '../../../Shared/Themes/app_text_styles.dart';
import '../../../Shared/Widgets/input_text/input_text_widget.dart';

// ignore: camel_case_types, must_be_immutable
class radio_page extends StatefulWidget {
  String nome;
  String idade;
  String? curso;
  String? cidade;
  // ignore: use_key_in_widget_constructors
  radio_page(
      {required this.nome,
      required this.idade,
      required this.curso,
      required this.cidade});

  @override
  State<radio_page> createState() => _radio_pageState();
}

// ignore: camel_case_types
class _radio_pageState extends State<radio_page> {
  int val = -1;

  final _feedback = TextEditingController();
  String? _manuseio;
  String? _instrucoes;
  String? _leritem;
  String? _fontes;
  String? _cores;
  // String? _manuseio;

  // fim das variaveis de cadastro do visitante
  // inicio do autocomplete

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        toolbarHeight: size.height * 0.15,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.logoTamandua,
                  height: size.height * 0.08,
                ),
                Container(
                  padding: const EdgeInsets.all(11.0),
                  child: Text(
                    "MuHNA",
                    style: (TextStyles.teste),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  "Museu de Historia Natural do Araguaia",
                  style: (TextStyles.subtitlelogo),
                ),
              ],
            ),
          ],
        ),
      ),
      body: (SizedBox(
        // width: size.width,
        height: size.height,
        child: Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: [
                    const Text(
                      "Como foi sua experiência ao usar o aplicativo?",
                      style: TextStyle(fontSize: 18),
                    ),
                    const Divider(),
                    RadioListTile(
                      title: const Text("Boa"),
                      value: "Boa",
                      groupValue: _manuseio,
                      onChanged: (value) {
                        setState(() {
                          _manuseio = value.toString();
                        });
                      },
                      activeColor: Colors.green,
                    ),
                    RadioListTile(
                      title: const Text("ruim"),
                      value: "ruim",
                      groupValue: _manuseio,
                      onChanged: (value) {
                        setState(() {
                          _manuseio = value.toString();
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    RadioListTile(
                      title: const Text("indiferente"),
                      value: "indiferente",
                      groupValue: _manuseio,
                      onChanged: (value) {
                        setState(() {
                          _manuseio = value.toString();
                        });
                      },
                      activeColor: Colors.yellow,
                    ),
                    Divider(
                      color: AppColors.primary,
                    ),
                    const Text(
                      "As instruçoes para ler o Qr Code bem como sua utiliação estava de facil entendimento?",
                      style: TextStyle(fontSize: 18),
                    ),
                    const Divider(),
                    RadioListTile(
                      title: const Text("Boa"),
                      value: "Boa",
                      groupValue: _instrucoes,
                      onChanged: (value) {
                        setState(() {
                          _instrucoes = value.toString();
                        });
                      },
                      activeColor: Colors.green,
                    ),
                    RadioListTile(
                      title: const Text("ruim"),
                      value: "ruim",
                      groupValue: _instrucoes,
                      onChanged: (value) {
                        setState(() {
                          _instrucoes = value.toString();
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    RadioListTile(
                      title: const Text("indiferente"),
                      value: "indiferente",
                      groupValue: _instrucoes,
                      onChanged: (value) {
                        setState(() {
                          _instrucoes = value.toString();
                        });
                      },
                      activeColor: Colors.yellow,
                    ),
                    Divider(
                      color: AppColors.primary,
                    ),
                    const Text(
                      "Como foi a sua leitura sobre o item scaneado?",
                      style: TextStyle(fontSize: 18),
                    ),
                    const Divider(),
                    RadioListTile(
                      title: const Text("Boa"),
                      value: "Boa",
                      groupValue: _leritem,
                      onChanged: (value) {
                        setState(() {
                          _leritem = value.toString();
                        });
                      },
                      activeColor: Colors.green,
                    ),
                    RadioListTile(
                      title: const Text("ruim"),
                      value: "ruim",
                      groupValue: _leritem,
                      onChanged: (value) {
                        setState(() {
                          _leritem = value.toString();
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    RadioListTile(
                      title: const Text("indiferente"),
                      value: "indiferente",
                      groupValue: _leritem,
                      onChanged: (value) {
                        setState(() {
                          _leritem = value.toString();
                        });
                      },
                      activeColor: Colors.yellow,
                    ),
                    Divider(
                      color: AppColors.primary,
                    ),
                    const Text(
                      "As fontes usadas dentro do aplicativo, ajudaram ou atrapalharam a sua experiencia?",
                      style: TextStyle(fontSize: 18),
                    ),
                    const Divider(),
                    RadioListTile(
                      title: const Text("Ajudou"),
                      value: "Ajudou",
                      groupValue: _fontes,
                      onChanged: (value) {
                        setState(() {
                          _fontes = value.toString();
                        });
                      },
                      activeColor: Colors.green,
                    ),
                    RadioListTile(
                      title: const Text("Atrapalhou"),
                      value: "Atrapalhou",
                      groupValue: _fontes,
                      onChanged: (value) {
                        setState(() {
                          _fontes = value.toString();
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    RadioListTile(
                      title: const Text("Indiferente"),
                      value: "Indiferente",
                      groupValue: _fontes,
                      onChanged: (value) {
                        setState(() {
                          _fontes = value.toString();
                        });
                      },
                      activeColor: Colors.yellow,
                    ),
                    Divider(
                      color: AppColors.primary,
                    ),
                    const Text(
                      "As Cores usadas dentro do aplicativo, ajudaram ou atrapalharam a sua experiencia?",
                      style: TextStyle(fontSize: 18),
                    ),
                    const Divider(),
                    RadioListTile(
                      title: const Text("Ajudou"),
                      value: "Ajudou",
                      groupValue: _cores,
                      onChanged: (value) {
                        setState(() {
                          _cores = value.toString();
                        });
                      },
                      activeColor: Colors.green,
                    ),
                    RadioListTile(
                      title: const Text("Atrapalhou"),
                      value: "Atrapalhou",
                      groupValue: _cores,
                      onChanged: (value) {
                        setState(() {
                          _cores = value.toString();
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    RadioListTile(
                      title: const Text("Indiferente"),
                      value: "Indiferente",
                      groupValue: _cores,
                      onChanged: (value) {
                        setState(() {
                          _cores = value.toString();
                        });
                      },
                      activeColor: Colors.yellow,
                    ),
                    Divider(
                      height: size.height * 0.1,
                      color: AppColors.primary,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: size.height * 0.1,
                      child: InputTextWidget(
                        label: "Gostaria de deixar uma opinião?",
                        icon: Icons.feed_outlined,
                        onChanged: (String feedback) {},
                        // onChanged: (value) => (),
                        controller: _feedback,
                        validator: (feedback) {
                          if (feedback == null || feedback.isEmpty) {
                            return 'Este espaço não pode ficar em branco';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                          style: ElevatedButton.styleFrom(
                              shape: (RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                              side: BorderSide(color: AppColors.primary),
                              primary: AppColors.background,
                              onPrimary: AppColors.primary,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13),
                              textStyle: const TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold)),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            CadastroVisitante(
                                widget.nome.toString(),
                                widget.idade.toString(),
                                widget.curso.toString(),
                                widget.cidade);
                            clearText();
                          },
                          style: ElevatedButton.styleFrom(
                              shape: (RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                              side: BorderSide(color: AppColors.primary),
                              primary: AppColors.background,
                              onPrimary: AppColors.primary,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13),
                              textStyle: const TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold)),
                          child: const Text('Cadastrar'),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      )),
    );
  }

  void clearText() {
    //  Navigator.pushAndRemoveUntil(
    //               context,
    //               MaterialPageRoute(builder: (context) => const HomePage()),
    //               ModalRoute.withName("/Home"));

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const ObrigadoPage()),
        ModalRoute.withName("/obrigado"));

    // Navigator.of(context)
    //     .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage()));
    // Navigator.of(context).popUntil(ModalRoute.withName("/home"));
  }

  // Fim da criação do autocomplete
  // ignore: non_constant_identifier_names
  void CadastroVisitante(
      String nome, String idade, String? curso, String? cidade) async {
    try {
      List<String> cidadeEstado = cidade!.split(" - ");

      DateTime now = DateTime.now();
      var dateString = DateFormat('dd-MM-yyyy').format(now);

      final visitante = {
        VisitanteFields.data: dateString,
        VisitanteFields.nome: nome,
        // VisitanteFields.instituicao: _instituicaoController.text,
        VisitanteFields.idade: idade,
        VisitanteFields.curso: curso,
        VisitanteFields.cidade: cidadeEstado[0],
        VisitanteFields.estado: cidadeEstado[1],

        VisitanteFields.manuseio: _manuseio,
        VisitanteFields.instrucoes: _instrucoes,
        VisitanteFields.lerItem: _leritem,
        VisitanteFields.fontes: _fontes,
        VisitanteFields.cores: _cores,

        VisitanteFields.feedback: _feedback.text,
      };

      await VisitanteSheetsApi.insert([visitante]);
    } catch (e) {
      print("falhou aqui");
    }
  }

  void Sucesso() {
    showInfoDialog(
      false,
      context,
      ":) Obrigado",
      "Sua avaliação foi anotada com sucesso",
      "OK",
    );
  }
}
