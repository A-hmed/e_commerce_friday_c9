import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/api/request/register_request_body.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/data/repos/auth_repo/auth_repo_impl.dart';
import 'package:injectable/injectable.dart';

abstract class AuthOnlineDS {
  Future<Either<String, bool>> login(String email, String password);

  Future<Either<Failure, void>> register(RegisterRequestBody body);
}
