import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repos/auth_repo/auth_repo.dart';

@injectable
class LoginUseCase {
  AuthRepo repo;

  LoginUseCase(this.repo);

  Future<Either<String, bool>> execute(String email, String password) {
    return repo.login(email, password);
  }
}
