import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/request/register_request_body.dart';
import 'package:e_commerce_friday_c9/data/model/response/auth_response.dart';
import 'package:e_commerce_friday_c9/domain/repos/auth_repo/data_sources/auth_online_data_source.dart';
import 'package:e_commerce_friday_c9/ui/utils/end_points.dart';
import 'package:e_commerce_friday_c9/ui/utils/shared_utils.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthOnlineDataSourceImpl extends AuthOnlineDataSource {
  Future<Either<String, bool>> login(String email, String password) async {
    try {
      Uri url = Uri.https(EndPoints.baseUrl, EndPoints.login);
      Response serverResponse =
          await post(url, body: {"email": email, "password": password});
      AuthResponse authResponse =
          AuthResponse.fromJson(jsonDecode(serverResponse.body));
      if (serverResponse.statusCode >= 200 && serverResponse.statusCode < 300) {
        SharedPrefsUtils().saveUser(authResponse.user!);
        return Right(true);
      } else {
        return Left(authResponse.message ??
            "Something went wrong please try again later");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> register(RegisterRequestBody body) async {
    try {
      Uri url = Uri.https(EndPoints.baseUrl, EndPoints.register);
      Response serverResponse = await post(url, body: body.toJson());
      print("Register body: ${serverResponse.body}");
      AuthResponse authResponse =
          AuthResponse.fromJson(jsonDecode(serverResponse.body));
      if (serverResponse.statusCode >= 200 && serverResponse.statusCode < 300) {
        SharedPrefsUtils().saveUser(authResponse.user!);
        return Right(true);
      } else {
        String message = authResponse.errors != null
            ? "${authResponse.errors!.param}"
                " ${authResponse.errors!.msg}"
            : authResponse.message ??
                "Something went wrong please try again later";
        return Left(message);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
