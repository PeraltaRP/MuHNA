import 'package:flutter/material.dart';
import 'package:muhna/Modulos/Api_Tainacan/conexao_tainacan.dart';
import 'package:muhna/Shared/Themes/app_colors.dart';
import 'package:muhna/Shared/Themes/app_images.dart';
import 'package:muhna/Shared/Themes/app_text_styles.dart';

class ListarItemTainacan2 extends StatefulWidget {
  String codigoUrl;
  ListarItemTainacan2({required this.codigoUrl});

  @override
  State<ListarItemTainacan2> createState() => _ListarItemTainacan2State();
}

class _ListarItemTainacan2State extends State<ListarItemTainacan2> {
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
                    "MuHNA tela lista item",
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
                  "Museu de História Natural do Araguaia",
                  style: (TextStyles.subtitlelogo),
                ),
              ],
            ),
          ],
        ),
      ),
        body: FutureBuilder(
            future: ApiTainacan.getItem(widget.codigoUrl.toString()),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(
                width: 90,
                height: 90,
                child: CircularProgressIndicator(
                  valueColor:AlwaysStoppedAnimation<Color>(Color(0xFF926F6C)),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Carregando Resultado...'),
          ),
        ],
      );
              }
              return Column(
                children: [
                  Image.network(snapshot.data[0].titulo.toString()),
                  Text("id ${snapshot.data[0].id}"),
                  Text(snapshot.data[0].titulo)
                ],
              );
            }));
    // } else {
    //   return ListView.builder(
    //     itemCount: snapshot.data.length,
    //     itemBuilder: (context, indice) {
    //       return ListTile(
    //         leading: Image.network(snapshot.data[indice].imagem),
    //         // ignore: unnecessary_string_interpolations
    //         title: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               '${snapshot.data[indice].produto}',
    //               style: const TextStyle(fontSize: 20),
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 Text(
    //                   // ignore: prefer_interpolation_to_compose_strings
    //                   'R\$' +
    //                       snapshot.data[indice].preco.toString(),
    //                   style: const TextStyle(color: Colors.red),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //         // ignore: prefer_interpolation_to_compose_strings
    //         subtitle: Text(snapshot.data[indice].descricao
    //                 .toString()
    //                 .substring(0, 50) +
    //             '...'),
    //         onTap: () {
    //           print('${snapshot.data[indice].produto}');

    //           Navigator.push(context,
    //               MaterialPageRoute(builder: (context) {
    //             return DetralhesProdutos(
    //               produtoId: snapshot.data[indice].produtoId,
    //               produto: snapshot.data[indice].produto,
    //               descricao: snapshot.data[indice].descricao,
    //               imagem: snapshot.data[indice].imagem,
    //               preco: snapshot.data[indice].preco,
    //             );
    //           }));
    //         },
    //       );
    //     },
    //   );
    // }
    // })),
  }
}
