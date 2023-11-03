import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/request/register_request_body.dart';

abstract class AuthOnlineDataSource {
  Future<Either<String, bool>> login(String email, String password);

  Future<Either<String, bool>> register(RegisterRequestBody body);
}
