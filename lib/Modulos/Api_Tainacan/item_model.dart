class Item {
  Item({required this.titulo, required this.descricao});
  final String? titulo;
  final String? descricao;

  factory Item.fromJson(Map<String, dynamic> data) {
    final title = data['title'] as String;
    final description = data['description'] as String;

    return Item(titulo: title, descricao: description);
  }
}
