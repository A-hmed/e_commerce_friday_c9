import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/api/request/register_request_body.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/auth_response.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/data/utils/shared_pref_utils.dart';
import 'package:e_commerce_friday_c9/domain/repos/auth_repo/data_sources/auth_online_ds.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthOnlineDSImpl extends AuthOnlineDS {
  SharedPrefUtils sharedPrefUtils;

  AuthOnlineDSImpl(this.sharedPrefUtils);

  @override
  Future<Either<String, bool>> login(String email, String password) async {
    Uri uri = Uri.https("ecommerce.routemisr.com", "/api/v1/auth/signin");
    Response response =
    await post(uri, body: {"email": email, "password": password});
    AuthResponse authResponse =
    AuthResponse.fromJson(jsonDecode(response.body));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      sharedPrefUtils.saveUser(authResponse.user!);
      sharedPrefUtils.saveToken(authResponse.token!);
      return const Right(true);
    } else {
      return Left(authResponse.message ??
          "Something went wrong please try again later");
    }
  }

  Future<Either<Failure, void>> register(RegisterRequestBody body) async {
    Uri uri = Uri.https("ecommerce.routemisr.com", "/api/v1/auth/signup");
    Response response =
    await post(uri, body: body.toJson());
    AuthResponse authResponse =
    AuthResponse.fromJson(jsonDecode(response.body));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      sharedPrefUtils.saveUser(authResponse.user!);
      sharedPrefUtils.saveToken(authResponse.token!);
      return const Right(0);
    } else {
      return Left(Failure(authResponse.message ??
          "Something went wrong please try again later"));
    }
  }
}
