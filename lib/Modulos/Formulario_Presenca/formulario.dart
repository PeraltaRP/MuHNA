import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:muhna/Modulos/API/api_formulario.dart';

import '../../Shared/Themes/app_colors.dart';
import '../../Shared/Themes/app_images.dart';
import '../../Shared/Themes/app_text_styles.dart';
import '../../Shared/Widgets/input_text/input_text_widget.dart';

class ForluarioPage extends StatefulWidget {
  const ForluarioPage({Key? key}) : super(key: key);

  @override
  State<ForluarioPage> createState() => _ForluarioPageState();
}

class _ForluarioPageState extends State<ForluarioPage> {
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        toolbarHeight: size.height * 0.15,
        title: Row(
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
                        return 'please';
                      }
                      return null;
                    },
                  ),
                  InputTextWidget(
                    label: "Instituição",
                    icon: Icons.account_balance_outlined,
                    onChanged: (String instituicao) {},
                    controller: _instituicaoController,
                  ),
                  InputTextWidget(
                    label: "Idade",
                    icon: Icons.star_border_outlined,
                    onChanged: (String idade) {},
                    controller: _idadeController,
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
                                    _cidadeController = value as String?;
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
                              ElevatedButton(
                                onPressed: () async {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (_formKey.currentState!.validate()) {
                                    bool deucerto = await Cadastrando_visitante(_nomeController.text, _instituicaoController.text, _cidadeController, _idadeController.text);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    if (deucerto) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackbar);
                                    } else {}
                                  }
                                },
                                child: Text('Cadasrar'),
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
}
