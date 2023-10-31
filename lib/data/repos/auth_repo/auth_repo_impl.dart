import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/domain/repos/auth_repo/auth_repo.dart';
import 'package:e_commerce_friday_c9/domain/repos/auth_repo/data_sources/auth_online_ds.dart';

class AuthRepoImpl extends AuthRepo {
  AuthOnlineDS onlineDS;
  Connectivity connectivity;

  AuthRepoImpl(this.onlineDS, this.connectivity);

  Future<Either<String, bool>> login(String email, String password) async {
    final connectivityResult = await (connectivity.checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      return onlineDS.login(email, password);
    } else {
      return const Left(
          "Please check your internet connection and try again later");
    }
  }
}
