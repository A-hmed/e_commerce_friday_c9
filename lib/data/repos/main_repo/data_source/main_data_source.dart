import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/failures.dart';
import 'package:e_commerce_friday_c9/data/model/response/categories_response.dart';
import 'package:e_commerce_friday_c9/data/model/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/products_response.dart';
import 'package:e_commerce_friday_c9/ui/utils/constants.dart';
import 'package:e_commerce_friday_c9/ui/utils/end_points.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainDataSource {
  Future<Either<Failure, List<CategoryDM>>> getCategories() async {
    try {
      Uri url = Uri.https(EndPoints.baseUrl, EndPoints.categories);
      Response serverResponse = await get(url);
      Map json = jsonDecode(serverResponse.body);
      CategoriesResponse categoriesResponse = CategoriesResponse.fromJson(json);
      if (serverResponse.statusCode >= 200 &&
          serverResponse.statusCode < 300 &&
          categoriesResponse.data != null) {
        return Right(categoriesResponse.data!);
      } else {
        return Left(Failure(
            categoriesResponse.message ?? Constants.defaultErrorMessage));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, List<ProductDM>>> getProducts() async {
    try {
      Uri url = Uri.https(EndPoints.baseUrl, EndPoints.products);
      print(url.toString());
      Response serverResponse = await get(url);
      Map json = jsonDecode(serverResponse.body);
      ProductsResponse productResponse = ProductsResponse.fromJson(json);
      print("getProducts Body: ${json}");
      if (serverResponse.statusCode >= 200 &&
          serverResponse.statusCode < 300 &&
          productResponse.data != null) {
        return Right(productResponse.data!);
      } else {
        return Left(
            Failure(productResponse.message ?? Constants.defaultErrorMessage));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
