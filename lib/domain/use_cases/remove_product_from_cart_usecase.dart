import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/failures.dart';
import '../../data/model/response/cart_dm.dart';
import '../repos/main_repo/main_repo.dart';

@injectable
class RemoveProductFromCartUseCase {
  MainRepo repo;

  RemoveProductFromCartUseCase(this.repo);

  Future<Either<Failure, CartDM>> execute(String id) {
    return repo.removeProductFromCart(id);
  }
}
