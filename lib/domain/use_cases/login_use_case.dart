import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/repos/auth_repo/auth_repo_impl.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/failures.dart';

@injectable
class LoginUseCase {
  AuthRepoImpl repo;

  LoginUseCase(this.repo);

  Future<Either<Failure, bool>> execute(String email, String password) {
    return repo.login(email, password);
  }
}
