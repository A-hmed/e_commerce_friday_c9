import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

extension NetworkExtensions on Connectivity {
  Future<bool> isInternetConnected() async {
    ConnectivityResult connectivityResult = await checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else {
      return false;
    }
  }
}

extension Percetages on num {
  double h(BuildContext context) {
    return MediaQuery.of(context).size.height * (this / 100);
  }

  double w(BuildContext context) {
    return MediaQuery.of(context).size.width * (this / 100);
  }
}
