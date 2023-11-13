import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/failures.dart';
import '../../data/model/response/cart_dm.dart';
import '../repos/main_repo/main_repo.dart';

@injectable
class GetLoggedUserCartUseCase {
  MainRepo repo;

  GetLoggedUserCartUseCase(this.repo);

  Future<Either<Failure, CartDM>> execute() {
    return repo.getLoggedUserCart();
  }
}
