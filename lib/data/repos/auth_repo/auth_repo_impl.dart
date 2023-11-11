import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/request/register_request_body.dart';
import 'package:e_commerce_friday_c9/data/repos/auth_repo/data_sources/auth_online_data_source.dart';
import 'package:e_commerce_friday_c9/domain/repos/auth_repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  AuthOnlineDataSourceImpl onlineDataSource;
  Connectivity connectivity = Connectivity();

  AuthRepoImpl(this.onlineDataSource, this.connectivity);

  @override
  Future<Either<String, bool>> login(String email, String password) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      return onlineDataSource.login(email, password);
    } else {
      return Left("Please check your internet connection");
    }
  }

  @override
  Future<Either<String, bool>> register(RegisterRequestBody body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      return onlineDataSource.register(body);
    } else {
      return Left("Please check your internet connection");
    }
  }
}
