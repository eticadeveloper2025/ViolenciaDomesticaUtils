import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:violencia_domestica_utils/src/util/constants.dart';
import 'package:violencia_domestica_utils/src/util/public_requests_token_crypt.dart';

class PublicRequestsSecurityUtils {
  static final PublicRequestsTokenCrypt _tokenCrypt = PublicRequestsTokenCrypt(secretKey: apiSecretToken);

  // Token gerado uma única vez
  static final String _securityToken = _tokenCrypt.generateSecurityToken();

  // Adiciona o token de segurança aos parâmetros da URL
  static Map<String, String> addSecurityToken(Map<String, String> params) {
    final secureParams = Map<String, String>.from(params);
    secureParams['secretToken'] = _securityToken;
    return secureParams;
  }

  // Adiciona o token de segurança ao header da requisição
  static Map<String, String> addSecurityHeader(Map<String, String> headers) {
    final secureHeaders = Map<String, String>.from(headers);
    secureHeaders['X-Secret-Token'] = _securityToken;
    return secureHeaders;
  }

  // Exemplo: Fazer uma requisição GET com o token seguro
  static Future<http.Response> secureGet(String url, {Map<String, String>? params}) async {
    final secureParams = addSecurityToken(params ?? {});
    final uri = Uri.parse(url).replace(queryParameters: secureParams);

    return await http.get(uri);
  }

  // Exemplo: Fazer uma requisição POST com o token seguro
  static Future<http.Response> securePost(String url, dynamic body, {Map<String, String>? headers}) async {
    final secureHeaders = addSecurityHeader(headers ?? {});

    // Se preferir enviar por parâmetro em vez de header
    final uri = Uri.parse(url).replace(queryParameters: {'secretToken': _securityToken});

    return await http.post(uri, headers: secureHeaders, body: jsonEncode(body));
  }
}
