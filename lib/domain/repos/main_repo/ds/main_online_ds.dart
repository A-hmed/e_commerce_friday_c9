import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/product_dm.dart';

import '../../../../data/model/failure.dart';

abstract class MainOnlineDS {
  Future<Either<Failure, List<CategoryDM>>> getCategories();

  Future<Either<Failure, List<ProductDM>>> getProducts();
}
