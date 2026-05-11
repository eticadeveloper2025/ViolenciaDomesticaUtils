import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:brasil_fields/brasil_fields.dart';
import 'package:violencia_domestica_utils/src/model/endereco_map_box_model.dart';
import 'package:violencia_domestica_utils/src/util/constants.dart';
import 'package:violencia_domestica_utils/src/util/public_requests_security_utils.dart';

class ApiService {
  Future<EnderecoMapBox> consultarEndereco(
    double? latitude,
    double? longitude,
  ) async {
    try {
      final resultado = await PublicRequestsSecurityUtils.secureGet(
        '$urlAPI/api/consultar_endereco',
        params: {
          'token': mapBoxToken,
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
        },
      );
      if (resultado.statusCode != 200)
        throw json.decode(resultado.body)['error'];

      return EnderecoMapBox.fromJson(json.decode(resultado.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> enviarSMS(
    String numeroRemetente,
    String numeroDestinatario,
    String mensagem,
  ) async {
    try {
      final resultado = await PublicRequestsSecurityUtils.securePost(
        "$urlAPI/api/enviar_sms",
        {
          'codigo': apiSecretToken,
          'enviado_por':
              '55${UtilBrasilFields.obterTelefone(numeroRemetente, mascara: false)}',
          'numero': numeroDestinatario,
          'mensagem': mensagem,
        },
        headers: requestHeaders,
      );

      if (resultado.statusCode != 200 && resultado.statusCode != 502) {
        throw json.decode(resultado.body)['error'] ??
            json.decode(resultado.body)['Message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> enviarMensagemWhatsApp(
    String numeroDestinatario,
    String mensagem,
  ) async {
    print("MESAGGEEEEEEEE => $mensagem");
    try {
      final url =
          'https://api.z-api.io/instances/$zapiInstanceId/token/$zapiInstanceToken/send-text';
      final headers = <String, String>{'Content-Type': 'application/json'};
      if (zapiClientToken.isNotEmpty) headers['Client-Token'] = zapiClientToken;
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode({'phone': numeroDestinatario, 'message': mensagem}),
      );
      print("STATUS ZAPI: ${response.statusCode} - ${response.body}");
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw 'Falha ao enviar mensagem WhatsApp: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      print("DEU ALGUM ERRO AO ENVIAR WHATSAPP: $e");
      rethrow;
    }
  }
}
