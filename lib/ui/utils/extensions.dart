import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

extension ConnectivityExtenstions on Connectivity {
  Future<bool> get isInternetConnected async {
    ConnectivityResult result = await checkConnectivity();
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi;
  }
}

extension ScreenPercentage on num {
  double h(BuildContext context) {
    return MediaQuery.of(context).size.height / this;
  }

  double w(BuildContext context) {
    return MediaQuery.of(context).size.width / this;
  }
}
