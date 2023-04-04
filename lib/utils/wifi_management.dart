import 'package:connectivity_plus/connectivity_plus.dart';

enum Status { WIFI, MOBILE, NO_INTERNET }

class WifiManagerment {
  Future<Status> getConnectivityResult() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return Status.MOBILE;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return Status.WIFI;
    }
    return Status.NO_INTERNET;
  }
}
