import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:violencia_domestica_utils/src/model/endereco_map_box_model.dart';

String urlAPI = dotenv.env['API_URL'] ?? '';
String urlWebSocket = dotenv.env['WEBSOCKET_URL'] ?? '';
String mapBoxToken = dotenv.env['MAP_BOX_TOKEN'] ?? '';
String apiSecretToken = dotenv.env['API_SECRET_TOKEN'] ?? '';
String zapiInstanceId = dotenv.env['ZAPI_INSTANCE_ID'] ?? '';
String zapiInstanceToken = dotenv.env['ZAPI_INSTANCE_TOKEN'] ?? '';
String zapiClientToken = dotenv.env['ZAPI_CLIENT_TOKEN'] ?? '';
EnderecoMapBox? currentLocation;

Map<String, String> requestHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Accept': 'application/json',
};
