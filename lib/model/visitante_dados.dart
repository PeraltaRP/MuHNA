class VisitanteDados {
  String _data;
  String _nome;
  String _instituicao;
  String _idade;
  String _cidade;
  String _estado;

  VisitanteDados(
      this._data, this._nome, this._instituicao,this._idade, this._cidade, this._estado);

  String toParams() =>
      "?data=$_data&?nome=$_nome&?instituicao=$_instituicao&?idade=$_idade&?cidade=$_cidade&?estado=$_estado";
}
