import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/cart_dm.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/domain/repos/main_repo/main_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductToCartUseCase {
  MainRepo repo;

  AddProductToCartUseCase(this.repo);

  Future<Either<Failure, CartDM>> execute(String productId) {
    return repo.addProductToCart(productId);
  }
}
