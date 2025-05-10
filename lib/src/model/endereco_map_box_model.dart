import 'package:violencia_domestica_utils/src/model/municipio_model.dart';

class EnderecoMapBox {
  String? rua;
  double? latitude;
  double? longitude;
  Municipio? municipio;
  String? codigoPostal;

  EnderecoMapBox({this.rua, this.latitude, this.longitude, this.municipio, this.codigoPostal});

  EnderecoMapBox.fromJson(Map<String, dynamic> json) {
    rua = json['rua'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    municipio = json['municipio'] != null ? Municipio.fromJson(json['municipio']) : null;
    codigoPostal = json['codigo_postal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rua'] = rua;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    if (municipio != null) {
      data['municipio'] = municipio!.toJson();
    }
    data['codigo_postal'] = codigoPostal;
    return data;
  }
}
