import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/request/registe_request_body.dart';
import 'package:e_commerce_friday_c9/data/repos/auth_repo/auth_repo_impl.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/failures.dart';

@injectable
class RegisterUseCase {
  AuthRepoImpl repo;

  RegisterUseCase(this.repo);

  Future<Either<Failure, bool>> execute(RegisteRequestBody body) {
    return repo.register(body);
  }
}
