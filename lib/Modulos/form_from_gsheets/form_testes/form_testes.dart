import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:muhna/Modulos/form_from_gsheets/form_testes/radio.dart';
import 'package:muhna/Modulos/form_from_gsheets/form_testes/visitante_model.dart';
import 'package:muhna/Modulos/form_from_gsheets/form_testes/visitante_sheets_api.dart';

import 'package:muhna/Shared/Alertas/AlertDialog.dart';

import '../../../Shared/Themes/app_colors.dart';
import '../../../Shared/Themes/app_images.dart';
import '../../../Shared/Themes/app_text_styles.dart';
import '../../../Shared/Widgets/input_text/input_text_widget.dart';

// ignore: camel_case_types
class Form_Gsheet_Page extends StatefulWidget {
  const Form_Gsheet_Page({Key? key}) : super(key: key);

  @override
  State<Form_Gsheet_Page> createState() => _Form_Gsheet_PageState();
}

// ignore: camel_case_types
class _Form_Gsheet_PageState extends State<Form_Gsheet_Page> {
  bool _value = false;
  int val = -1;

  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _idade = TextEditingController();

  String? _curso;
  String? _cidade;

  // String? _manuseio;

  // fim das variaveis de cadastro do visitante
  // inicio do autocomplete
  bool isLoading = false;
  late List<String> autoCompleteCidades;
  late List<String> autoCompleteCursos;
  late TextEditingController controllercidade;
  late TextEditingController controllercurso;
  

  Future constroiAutoComplete() async {
    setState(() {
      isLoading = true;
    });
    final String cidadeJson =
        await rootBundle.loadString("assets/cidades/cidades.json");
    final String cursosJson =
        await rootBundle.loadString("assets/cursos/cursos.json");

    final List<dynamic> jsoncurso = jsonDecode(cursosJson);
    final List<dynamic> json = jsonDecode(cidadeJson);

    final List<String> jsonStringCidades = json.cast<String>();
    final List<String> jsonStringCursos = jsoncurso.cast<String>();

    setState(() {
      isLoading = false;
      autoCompleteCidades = jsonStringCidades;
      autoCompleteCursos = jsonStringCursos;
    });
  }

  @override
  void initState() {
    super.initState();
    constroiAutoComplete();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
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
                Container(
                  child: Text(
                    "Museu de Historia Natural do Araguaia",
                    style: (TextStyles.subtitlelogo),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Container(
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InputTextWidget(
                        label: "Nome",
                        icon: Icons.account_box_outlined,
                        onChanged: (String nome) {},
                        // onChanged: (value) => (),
                        controller: _nome,
                        validator: (nome) {
                          if (nome == null || nome.isEmpty) {
                            return 'Este espaço não pode ficar em branco';
                          }
                          return null;
                        },
                      ),
                      InputTextWidget(
                        label: "idade",
                        icon: Icons.star_border_outlined,
                        onChanged: (String idade) {},
                        // onChanged: (value) => (),
                        controller: _idade,
                        validator: (idade) {
                          if (idade == null || idade.isEmpty) {
                            return 'Este espaço não pode ficar em branco';
                          }
                          return null;
                        },
                      ),
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(1),
                              child: Column(
                                children: [
                                  Autocomplete(
                                    optionsBuilder:
                                        (TextEditingValue textEditingValue) {
                                      if (textEditingValue.text.isEmpty) {
                                        return const Iterable<String>.empty();
                                      } else {
                                        return autoCompleteCursos.where(
                                            (word) => word
                                                .toLowerCase()
                                                .contains(textEditingValue.text
                                                    .toLowerCase()));
                                      }
                                    },
                                    onSelected: (value) {
                                      setState(() {
                                        _curso = value as String;
                                      });
                                    },
                                    fieldViewBuilder: (context, controller,
                                        focusNode, onEditingComplete) {
                                      this.controllercurso = controller;

                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: controller,
                                              focusNode: focusNode,
                                              style: TextStyles.input,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  labelText: "Curso",
                                                  labelStyle: TextStyles.input,
                                                  icon: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 18),
                                                        child: Icon(
                                                          Icons.school_outlined,
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 1,
                                                        height: 48,
                                                        color: AppColors.stroke,
                                                      )
                                                    ],
                                                  ),
                                                  border: InputBorder.none),
                                            ),
                                            Divider(
                                              height: 1,
                                              thickness: 1,
                                              color: AppColors.stroke,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  Autocomplete(
                                    optionsBuilder:
                                        (TextEditingValue textEditingValue) {
                                      if (textEditingValue.text.isEmpty) {
                                        return const Iterable<String>.empty();
                                      } else {
                                        return autoCompleteCidades.where(
                                            (word) => word
                                                .toLowerCase()
                                                .contains(textEditingValue.text
                                                    .toLowerCase()));
                                      }
                                    },
                                    onSelected: (value) {
                                      setState(() {
                                        _cidade = value as String;
                                      });
                                    },
                                    fieldViewBuilder: (context, controller,
                                        focusNode, onEditingComplete) {
                                      this.controllercidade = controller;

                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: controller,
                                              focusNode: focusNode,
                                              style: TextStyles.input,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  labelText:
                                                      "Cidade de Origem - UF",
                                                  labelStyle: TextStyles.input,
                                                  icon: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 18),
                                                        child: Icon(
                                                          Icons
                                                              .location_city_outlined,
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 1,
                                                        height: 48,
                                                        color: AppColors.stroke,
                                                      )
                                                    ],
                                                  ),
                                                  border: InputBorder.none),
                                            ),
                                            Divider(
                                              height: 1,
                                              thickness: 1,
                                              color: AppColors.stroke,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
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
                              if (_formKey.currentState!.validate()) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => radio_page(
                                              nome: _nome.text,
                                              idade: _idade.text,
                                              curso: _curso,
                                              cidade: _cidade,
                                            )));
                              }
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
                            child: const Text('Continuar'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearText() {
    // _formKey.currentState?.reset();
    // _nome.clear();
    // // _instituicao.clear();
    // _cidade = "";
    // _idade.clear();
    // _feedback.clear();
    // FocusScope.of(context).requestFocus(FocusNode());
    // WidgetsBinding.instance.addPostFrameCallback((_) => controller.clear());

    // Navigator.pushNamed(context, "/home");
  }
}
