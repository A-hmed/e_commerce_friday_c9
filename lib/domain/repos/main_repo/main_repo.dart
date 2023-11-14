import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/cart_dm.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/product_dm.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';

abstract class MainRepo {
  Future<Either<Failure, List<CategoryDM>>> getCategories();

  Future<Either<Failure, List<ProductDM>>> getProducts();

  Future<Either<Failure, CartDM>> getLoggedCart();

  Future<Either<Failure, CartDM>> addProductToCart(String productId);

  Future<Either<Failure, CartDM>> removeProductFromCart(String productId);
}
