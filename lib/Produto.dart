// ignore_for_file: file_names

class Produto {
  String codigo;
  String descricao;
  String valorCusto;
  String valorTabela;
  String valorVenda;
  String qtdaEst;

  Produto(this.codigo, this.descricao, this.valorCusto, this.valorTabela,
      this.valorVenda, this.qtdaEst);
  Produto.fromJson(Map json)
      : codigo = json['codigo'],
        descricao = json['descricao'],
        valorCusto = json['valorCusto'],
        valorTabela = json['valorTabela'],
        valorVenda = json['valorVenda'],
        qtdaEst = json['qtdaEst'];
  //print(Produto.fromJson(json));
  Map toJson() {
    return {'codigo': codigo, 'descricao': descricao, 'valorCusto': valorCusto, 'valorTabela': valorTabela, 'valorVenda': valorVenda, 'qtdaEst': qtdaEst};
  }
}
