

// import 'package:flutter/material.dart';
// import 'package:muhna/Modulos/Localiza%C3%A7%C3%A3o/local_Controller.dart';

// final appKey = GlobalKey();

// class PostosPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: appKey,
//       appBar: AppBar(
//         title: Text('Postos'),
//       ),
//       body: ChangeNotifierProvider<PostosController>(
//         create: (context) => PostosController(),
//         child: Builder(builder: (context) {
//           final local = context.watch<PostosController>();
//           String mensagem = local.erro == '' ? 'Latitude: ${local.}'

//           return Center(child: Text(mensagem));
//           );
//         }),
//       ),
//     );
//   }
// }