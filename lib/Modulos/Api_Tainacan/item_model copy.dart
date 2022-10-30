class ItemScanneados {
  final List objetos;

  ItemScanneados(this.objetos);
}

class ItemScanneado {
  final int id;
  final String titulo;
  final String descricao;
  final String assetDocumento;
  final String assetTabnail;

  ItemScanneado(
    this.id,
    this.titulo,
    this.descricao,
    this.assetDocumento,
    this.assetTabnail,
  );

  factory ItemScanneado.fromJson(Map<String, dynamic> json) {
    return ItemScanneado(
      json['id'],
      json['titulo'],
      json['descricao'],
      json['assetDocumento'],
      json['assetTabnail']);
  }
}
