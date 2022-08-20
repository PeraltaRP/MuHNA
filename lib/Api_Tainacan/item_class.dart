import 'package:flutter/cupertino.dart';

class Item {
  List<Items>? items;
  String? template;
  List<Null>? filters;
  List<Null>? filtersArguments;

  Item({this.items, this.template, this.filters, this.filtersArguments});
}

class Items {
  int? id;
  String? title;
  String? description;
  String? documentMimetype;
  String? documentAsHtml;
  Metadata? metadata;

  Items(
      {this.id,
      this.title,
      this.description,
      this.documentMimetype,
      this.documentAsHtml,
      this.metadata});
}

class Metadata {
  Title? nomeCientifico;

  Metadata({
    this.nomeCientifico,
  });
}
