class Estabelecimento {
  final String nome;
  final String codigo;
  final int chave;
  final String? endereco;
  final String? uf;
  final String? bairro;
  final String? cnpj;
  final String? email;
  final String? cidade;
  final String? fone;
  final String? imgEmpresa;

  Estabelecimento({
    required this.nome,
    required this.chave,
    required this.codigo,
    this.bairro,
    this.cnpj,
    this.endereco,
    this.uf,
    this.email,
    this.cidade,
    this.fone,
    this.imgEmpresa,
  });

  static List<Map<String, dynamic>> dadosEstabelecimento = [];
}
