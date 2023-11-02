import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/request/registe_request_body.dart';

import '../../../data/model/failures.dart';

abstract class AuthRepo {
  const AuthRepo();

  Future<Either<Failure, bool>> login(String email, String password);

  Future<Either<Failure, bool>> register(RegisteRequestBody body);
}
