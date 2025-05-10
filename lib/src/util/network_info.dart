import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'messages.dart';

class NetworkInfo {
  static final noConnectionMessage = 'Não encontramos uma conexão com a internet.';
  static Future checkConnection({required Function onConnected, Function? onDisconnected}) async {
    if (await InternetConnection().hasInternetAccess) {
      return await onConnected();
    } else {
      if (onDisconnected != null) {
        await onDisconnected();
      } else {
        throw noConnectionMessage;
      }
    }
  }

  static showDisconnectMessage() async {
    return await Messages.showMessage(title: 'Ops!', content: noConnectionMessage);
  }
}
