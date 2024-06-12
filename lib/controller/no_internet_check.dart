import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  Rx<ConnectionStatus> connectionStatus = ConnectionStatus.connected.obs;

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    final ConnectivityResult result =
    await Connectivity().checkConnectivity();
    _updateConnectionStatus(result);
    Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      connectionStatus.value = ConnectionStatus.disconnected;
    } else {
      connectionStatus.value = ConnectionStatus.connected;
    }
  }
}

enum ConnectionStatus {
  connected,
  disconnected,
}
