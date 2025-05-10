import 'package:geolocator/geolocator.dart';

class Location {
  static final permissionsStartError = 'Erro de permissões: ';

  static Future<Position>? determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      throw '${permissionsStartError}Para continuar é preciso habilitar os serviços de localização do seu dispositivo.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        throw '${permissionsStartError}As permissões de localização foram negadas.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw '${permissionsStartError}As permissões de localização foram negadas permanentemente, não podemos solicitar permissões. Verifique as configurações do seu dispositivo.';
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
