class ItemScanneados {
  final List objetos;

  ItemScanneados(this.objetos);
}
class ItemScanneado{
  final int id;
  final String titulo;
  // final String descricao;
  // final String tipoAsset;
  // final String asset; //asset é referente a um link que pode ser uma imagem ou um video;
  // final String scientificName;

  ItemScanneado(
    this.id,
    this.titulo,
    // this.descricao,
    // this.tipoAsset,
    // this.asset,
    // this.scientificName
   );

   factory ItemScanneado.fromJson(Map<String, dynamic> json) {
    return ItemScanneado(
      json['id'],
      json['titulo'],
      // json['descricao'],
      // json['tipoAsset'],
      // json['asset'],
      // json['scientificName'],
    );
  }
  

}
