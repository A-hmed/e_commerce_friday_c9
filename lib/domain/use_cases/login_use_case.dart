import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/domain/repos/auth_repo/auth_repo.dart';

import '../../data/model/failures.dart';

class LoginUseCase {
  AuthRepo repo;

  LoginUseCase(this.repo);

  Future<Either<Failure, bool>> execute(String email, String password) {
    return repo.login(email, password);
  }
}
