class Estado {
  int? idEstado;
  String? nome;
  String? sigla;

  Estado({this.idEstado, this.nome, this.sigla});

  Estado.fromJson(Map<String, dynamic> json) {
    idEstado = json['id_estado'];
    nome = json['nome'];
    sigla = json['sigla'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_estado'] = idEstado;
    data['nome'] = nome;
    data['sigla'] = sigla;
    return data;
  }
}
