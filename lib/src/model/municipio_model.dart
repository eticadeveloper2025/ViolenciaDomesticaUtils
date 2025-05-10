import 'package:violencia_domestica_utils/src/model/estado_model.dart';

class Municipio {
  int? idMunicipio;
  Estado? estado;
  String? nome;
  int? codigoIbge;
  double? latitude;
  double? longitude;

  Municipio({this.idMunicipio, this.estado, this.nome, this.codigoIbge, this.latitude, this.longitude});

  Municipio.fromJson(Map<String, dynamic> json) {
    idMunicipio = json['id_municipio'];
    estado = json['estado'] != null ? Estado.fromJson(json['estado']) : null;
    nome = json['nome'];
    codigoIbge = json['codigo_ibge'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_municipio'] = idMunicipio;
    if (estado != null) {
      data['estado'] = estado!.toJson();
    }
    data['nome'] = nome;
    data['codigo_ibge'] = codigoIbge;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
