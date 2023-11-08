import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/failures.dart';
import 'package:e_commerce_friday_c9/data/model/response/cart_dm.dart';
import 'package:e_commerce_friday_c9/data/repos/main_repo/main_repo_impl.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserCartUseCase {
  MainRepoImpl repo;

  GetUserCartUseCase(this.repo);

  Future<Either<Failure, CartDM>> execute() async {
    return repo.getUserCart();
  }
}
