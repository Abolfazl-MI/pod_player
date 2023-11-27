import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pod_player/app/core/resources/connectivity_status.dart';
import 'package:pod_player/app/core/resources/data_state.dart';

class ConnectivityProvider {
  final Connectivity _connectivity;

  ConnectivityProvider(this._connectivity);

  /// check internet connection

  Future<DataState<AppConnectivityStatus>> checkInternet() async {
    try {
      ConnectivityResult _result = await _connectivity.checkConnectivity();
      if (_result == ConnectivityResult.mobile ||
          _result == ConnectivityResult.wifi ||
          _result == ConnectivityResult.vpn) {
        return const DataSuccess(AppConnectivityStatus.connected);
      } else {
        return const DataSuccess(AppConnectivityStatus.disconnected);
      }
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  /// internet connection stream check
  Stream<AppConnectivityStatus> connectionStream() async* {
    yield* _connectivity.onConnectivityChanged.map((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi ||
          event == ConnectivityResult.vpn) {
        return AppConnectivityStatus.connected;
      } else {
        return AppConnectivityStatus.disconnected;
      }
    });
  }
}
