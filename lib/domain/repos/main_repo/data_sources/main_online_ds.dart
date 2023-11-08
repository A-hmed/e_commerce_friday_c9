import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/failures.dart';
import 'package:e_commerce_friday_c9/data/model/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';

abstract class MainOnlineDS {
  Future<Either<Failure, List<CategoryDM>>> getCategories();

  Future<Either<Failure, List<ProductDM>>> getProducts();
}
