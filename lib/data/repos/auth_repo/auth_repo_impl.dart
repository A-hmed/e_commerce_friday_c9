import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/api/request/register_request_body.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/data/repos/auth_repo/data_sources/online_ds_impl.dart';
import 'package:e_commerce_friday_c9/domain/repos/auth_repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthRepoImpl extends AuthRepo {
  AuthOnlineDSImpl onlineDS;
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

  Future<Either<Failure, void>> register(RegisterRequestBody body) async {
    final connectivityResult = await (connectivity.checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      return onlineDS.register(body);
    } else {
      return Left(NetworkFailure(
          "Please check your internet connection and try again later"));
    }
  }
}
