import 'package:connectivity_plus/connectivity_plus.dart';

extension InternetAvailability on Connectivity {
  Future<bool> get isInternetConnected async {
    ConnectivityResult result = await checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      return true;
    }
    return false;
  }
}
