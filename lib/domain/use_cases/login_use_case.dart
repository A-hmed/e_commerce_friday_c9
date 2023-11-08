import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/domain/repos/auth_repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/failures.dart';

@injectable
class LoginUseCase {
  AuthRepo repo;
  LoginUseCase(this.repo);
  String email = "";
  String password = "";

  Future<Either<Failure, bool>> execute() {
    return repo.login(email, password);
  }
}
