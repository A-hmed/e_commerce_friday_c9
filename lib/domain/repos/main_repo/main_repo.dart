import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/data/model/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';

abstract class MainRepo {
  Future<Either<Failure, List<CategoryDM>>> getCategories();

  Future<Either<Failure, List<ProductDM>>> getProducts();
}
