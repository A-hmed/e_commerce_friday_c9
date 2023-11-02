import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/failures.dart';
import 'package:e_commerce_friday_c9/data/model/request/registe_request_body.dart';
import 'package:e_commerce_friday_c9/data/model/response/auth_response.dart';
import 'package:e_commerce_friday_c9/domain/repos/auth_repo/auth_repo.dart';
import 'package:e_commerce_friday_c9/ui/utils/shared_prefecences_utils.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthRepoImpl implements AuthRepo {
  SharedPrefUtils sharedPrefUtils;

  AuthRepoImpl(this.sharedPrefUtils);

  Future<Either<Failure, bool>> login(String email, String password) async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());

    ///Body
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      Uri url = Uri.https("ecommerce.routemisr.com", "/api/v1/auth/signin");
      print("Request body: ${{"email": email, "password": password}}");
      Response serverResponse =
          await post(url, body: {"email": email, "password": password});
      print("Login Response body: ${serverResponse.body}");
      AuthResponse authResponse =
          AuthResponse.fromJson(jsonDecode(serverResponse.body));
      if (serverResponse.statusCode >= 200 &&
          serverResponse.statusCode < 300 &&
          authResponse.token != null &&
          authResponse.user != null) {
        sharedPrefUtils.saveToken(authResponse.token!);
        sharedPrefUtils.saveUser(authResponse.user!);

        return Right(true);
      } else {
        return Left(Failure(
            authResponse.message ?? "Something wrong please try again later"));
      }
    } else {
      return Left(NetworkFailure(
          "Please check your internet connection and try again"));
    }
  }

  @override
  Future<Either<Failure, bool>> register(RegisteRequestBody body) async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());

    ///Body
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      Uri url = Uri.https("ecommerce.routemisr.com", "/api/v1/auth/signup");
      Response serverResponse = await post(url, body: body.toJson());
      AuthResponse authResponse =
          AuthResponse.fromJson(jsonDecode(serverResponse.body));
      if (serverResponse.statusCode >= 200 &&
          serverResponse.statusCode < 300 &&
          authResponse.token != null &&
          authResponse.user != null) {
        sharedPrefUtils.saveToken(authResponse.token!);
        sharedPrefUtils.saveUser(authResponse.user!);
        return Right(true);
      } else {
        return Left(Failure(
            authResponse.message ?? "Something wrong please try again later"));
      }
    } else {
      return Left(NetworkFailure(
          "Please check your internet connection and try again"));
    }
  }
}
