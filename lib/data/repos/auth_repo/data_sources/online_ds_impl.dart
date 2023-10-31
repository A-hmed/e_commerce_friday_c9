import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/auth_response.dart';
import 'package:e_commerce_friday_c9/domain/repos/auth_repo/data_sources/auth_online_ds.dart';
import 'package:http/http.dart';

class AuthOnlineDSImpl extends AuthOnlineDS {
  @override
  Future<Either<String, bool>> login(String email, String password) async {
    Uri uri = Uri.https("ecommerce.routemisr.com", "/api/v1/auth/signin");
    Response response =
        await post(uri, body: {"email": email, "password": password});
    AuthResponse authResponse =
        AuthResponse.fromJson(jsonDecode(response.body));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return const Right(true);
    } else {
      return Left(authResponse.message ??
          "Something went wrong please try again later");
    }
  }
}
