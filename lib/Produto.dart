// ignore_for_file: file_names

class Produto{
  String codigo;
  String descricao;
  String valorCusto;

  Produto(this.codigo,this.descricao,this.valorCusto);
  Produto.fromJson(Map json)
      : codigo = json['codigo'],
      descricao = json['descricao'],
      valorCusto = json['valorCusto'];
         //print(Produto.fromJson(json));
  Map toJson()
  {
    return {'codigo':codigo, 'descricao':descricao, 'valorCusto':valorCusto};
  }
}