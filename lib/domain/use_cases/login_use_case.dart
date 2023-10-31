import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/domain/repos/auth_repo/auth_repo.dart';

class LoginUseCase {
  AuthRepo repo;

  LoginUseCase(this.repo);

  Future<Either<String, bool>> execute(String email, String password) {
    return repo.login(email, password);
  }
}
