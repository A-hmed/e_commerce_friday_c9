import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/request/register_request_body.dart';
import 'package:e_commerce_friday_c9/data/repos/auth_repo/auth_repo_impl.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  AuthRepoImpl repo;

  RegisterUseCase(this.repo);

  Future<Either<String, bool>> execute(RegisterRequestBody body) {
    return repo.register(body);
  }
}
