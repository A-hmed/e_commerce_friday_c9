import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/request/registe_request_body.dart';
import 'package:e_commerce_friday_c9/domain/repos/auth_repo/auth_repo.dart';

import '../../data/model/failures.dart';

class RegisterUseCase {
  AuthRepo repo;

  RegisterUseCase(this.repo);

  Future<Either<Failure, bool>> execute(RegisteRequestBody body) {
    return repo.register(body);
  }
}
