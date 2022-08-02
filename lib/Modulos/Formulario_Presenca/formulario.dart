import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:muhna/Modulos/API/api_formulario.dart';
import 'package:muhna/Modulos/API/api_sheets.dart';
import 'package:muhna/model/visitante_controller.dart';
import 'package:muhna/model/visitante_dados.dart';

import '../../Shared/Alertas/AlertDialog.dart';
import '../../Shared/Themes/app_colors.dart';
import '../../Shared/Themes/app_images.dart';
import '../../Shared/Themes/app_text_styles.dart';
import '../../Shared/Widgets/input_text/input_text_widget.dart';
import '../../model/visitante_fields.dart';

class FormularioPage extends StatefulWidget {
  const FormularioPage({Key? key}) : super(key: key);

  @override
  State<FormularioPage> createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  // vaiaveis para o cadastro do visitante
  final _nomeController = TextEditingController();
  final _instituicaoController = TextEditingController();
  String? _cidadeController;
  final _idadeController = TextEditingController();
  // fim das variaveis de cadastro do visitante
  // inicio do autocomplete
  bool isLoading = false;
  late List<String> autoCompleteCidades;
  late TextEditingController controller;

  Future constroiAutoComplete() async {
    setState(() {
      isLoading = true;
    });
    final String cidadeJson =
        await rootBundle.loadString("assets/cidades/cidades.json");

    final List<dynamic> json = jsonDecode(cidadeJson);

    final List<String> jsonStringCidades = json.cast<String>();

    setState(() {
      isLoading = false;
      autoCompleteCidades = jsonStringCidades;
    });
  }

  @override
  void initState() {
    super.initState();
    constroiAutoComplete();
  }

// Fim da criação do autocomplete
  void CadastroVisitante() async {
    List<String> cidadeEstado = _cidadeController!.split(" - ");
    VisitanteDados visitante_dados = VisitanteDados(
        '02/08/2022',
        _nomeController.text,
        _instituicaoController.text,
        _idadeController.text,
        cidadeEstado[0],
        cidadeEstado[1]);

    VisitanteController visitante_controller =
        VisitanteController((String response) {
      print("Response: $response");
      if (response == VisitanteController.STATUS_SUCCESS) {
        _showSnackbar("Sucesso");
      } else {
        _showSnackbar("Error");
      }
    });
    _showSnackbar("Submiting Form");
    visitante_controller.submitForm(visitante_dados);
  }

  _showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
// _nomeController.text, _instituicaoController.text,cidadeEstado[0],cidadeEstado[1], _idadeController.tex
    //   print(_nomeController.text);
    // }
    //   final visitante = {
    //     VisitanteFields.nome: _nomeController.text.trim(),
    //     VisitanteFields.instituicao: _instituicaoController.text.trim(),
    //     VisitanteFields.idade: _idadeController.text.trim(),
    //     VisitanteFields.cidade: cidadeEstado[0],
    //     VisitanteFields.estado: cidadeEstado[1],
    //   };
    //   print(visitante[1]);
    //   await VisistanteSheetsApi.insert([visitante]);
  }

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
                Container(
                  child: Text(
                    "Museu de História Natural do Araguaia",
                    style: (TextStyles.subtitlelogo),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputTextWidget(
                    label: "Nome",
                    icon: Icons.account_box_outlined,
                    onChanged: (String nome) {},
                    // onChanged: (value) => (),
                    controller: _nomeController,
                    validator: (nome) {
                      if (nome == null || nome.isEmpty) {
                        return 'Este espaço não pode ficar em branco';
                      }
                      return null;
                    },
                  ),
                  InputTextWidget(
                    label: "Instituição",
                    icon: Icons.account_balance_outlined,
                    onChanged: (String instituicao) {},
                    controller: _instituicaoController,
                    validator: (instituicao) {
                      if (instituicao == null || instituicao.isEmpty) {
                        return 'Este espaço não pode ficar em branco';
                      }
                      return null;
                    },
                  ),
                  InputTextWidget(
                    label: "Idade",
                    icon: Icons.star_border_outlined,
                    onChanged: (String idade) {},
                    controller: _idadeController,
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
                                    return autoCompleteCidades.where((word) =>
                                        word.toLowerCase().contains(
                                            textEditingValue.text
                                                .toLowerCase()));
                                  }
                                },
                                onSelected: (value) {
                                  setState(() {
                                    _cidadeController = value as String;
                                  });
                                },
                                fieldViewBuilder: (context, controller,
                                    focusNode, onEditingComplete) {
                                  this.controller = controller;

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: controller,
                                          focusNode: focusNode,
                                          style: TextStyles.input,
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              labelText: "Cidade - UF",
                                              labelStyle: TextStyles.input,
                                              icon: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 18),
                                                    child: Icon(
                                                      Icons
                                                          .location_city_outlined,
                                                      color: AppColors.primary,
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/home');
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: (RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                        side: BorderSide(
                                            color: AppColors.primary),
                                        primary: AppColors.background,
                                        onPrimary: AppColors.primary,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 13),
                                        textStyle: const TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold)),
                                    child: const Text('Cancelar'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (_formKey.currentState!.validate()) {
                                        CadastroVisitante();

                                        // clearText();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: (RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                        side: BorderSide(
                                            color: AppColors.primary),
                                        primary: AppColors.background,
                                        onPrimary: AppColors.primary,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 13),
                                        textStyle: const TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold)),
                                    child: const Text('Cadastrar'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clearText() {
    _formKey.currentState?.reset();
    _nomeController.clear();
    _instituicaoController.clear();
    _cidadeController = "";
    _idadeController.clear();
  }

  //   bool respostaServidor = await cadastro(_nomeController.text,
  //       _instituicaoController.text, _cidadeController, _idadeController.text);

  //   print(respostaServidor);
  //   if (respostaServidor == true) {
  //     // ignore: use_build_context_synchronously
  //     showInfoDialog(
  //       false,
  //       context,
  //       "Tudo Certo :)",
  //       "Obrigado pela visita, volte sempre",
  //       "ok",
  //     );
  //   } else {
  //     // ignore: use_build_context_synchronously
  //     showInfoDialog(
  //       false,
  //       context,
  //       "Servidor Off Line",
  //       "Não é você! Sou eu. Eu que estou Offline ;(",
  //       "ok",
  //     );
  //   }

}
