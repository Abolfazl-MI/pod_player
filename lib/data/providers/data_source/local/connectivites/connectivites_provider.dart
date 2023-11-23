import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pod_player/app/core/resources/connectivity_status.dart';

class AppConnectivityProvider {
  final Connectivity _connectivity;

  AppConnectivityProvider(this._connectivity);

  /// check internet connection and only return the result
  Future<ConnectivityResult> checkConnection() async {
    return await _connectivity.checkConnectivity();
  }

  // provide stream of AppConnectivityStatus
  Stream<AppConnectivityStatus> connectionStream() async* {
    yield* _connectivity.onConnectivityChanged.map((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        return AppConnectivityStatus.connected;
      } else {
        return AppConnectivityStatus.disconnected;
      }
    });
  }
}
