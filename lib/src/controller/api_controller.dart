import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:violencia_domestica_utils/src/service/api_service.dart';
import 'package:violencia_domestica_utils/src/util/constants.dart';
import 'package:violencia_domestica_utils/src/util/location.dart';
import 'package:violencia_domestica_utils/src/util/messages.dart';
import 'package:violencia_domestica_utils/src/util/network_info.dart';

class APIController extends GetxController {
  final apiService = ApiService();

  Future<void> consultarEnderecoAtual() async {
    try {
      return await NetworkInfo.checkConnection(
        onConnected: () async {
          LocationPermission permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied) {
            await Messages.showMessage(
              title: 'Permissão de Localização',
              content:
                  'Para identificar seu endereço atual, precisamos que você autorize o acesso à sua localização exata.\nPor favor, selecione "Localização Precisa" na próxima tela, caso seja solicitado.',
            );
          }

          Position? location = await Location.determinePosition();
          currentLocation = await apiService.consultarEndereco(location?.latitude, location?.longitude);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> enviarSMS(String numeroRemetente, String numeroDestinatario, String conteudo) async {
    try {
      await NetworkInfo.checkConnection(
        onConnected: () async {
          await apiService.enviarSMS(numeroRemetente, numeroDestinatario, conteudo);
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
