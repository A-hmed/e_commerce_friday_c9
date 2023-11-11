import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/data/model/response/categories_response.dart';
import 'package:e_commerce_friday_c9/data/model/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/products_response.dart';
import 'package:e_commerce_friday_c9/domain/repos/main_repo/ds/main_online_ds.dart';
import 'package:e_commerce_friday_c9/ui/utils/constants.dart';
import 'package:e_commerce_friday_c9/ui/utils/end_points.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MainOnlineDS)
class MainOnlineDSImpl extends MainOnlineDS {
  @override
  Future<Either<Failure, List<CategoryDM>>> getCategories() async {
    try {
      Uri url = Uri.https(EndPoints.baseUrl, EndPoints.categories);
      Response serverResponse = await get(url);
      CategoriesResponse myResponse =
          CategoriesResponse.fromJson(jsonDecode(serverResponse.body));
      if (serverResponse.statusCode >= 200 && serverResponse.statusCode < 300) {
        return Right(myResponse.data!);
      } else {
        return Left(
            Failure(myResponse.message ?? Constants.defaultErrorMessage));
      }
    } catch (error, stackTrace) {
      print("MainOnlineDSImpl-getCategories: $error, $stackTrace");
      return Left(Failure(Constants.defaultErrorMessage));
    }
  }

  @override
  Future<Either<Failure, List<ProductDM>>> getProducts() async {
    try {
      Uri url = Uri.https(EndPoints.baseUrl, EndPoints.products);
      Response serverResponse = await get(url);
      ProductsResponse myResponse =
          ProductsResponse.fromJson(jsonDecode(serverResponse.body));
      if (serverResponse.statusCode >= 200 && serverResponse.statusCode < 300) {
        return Right(myResponse.data!);
      } else {
        return Left(
            Failure(myResponse.message ?? Constants.defaultErrorMessage));
      }
    } catch (error, stackTrace) {
      print("MainOnlineDSImpl-getCategories: $error, $stackTrace");
      return Left(Failure(Constants.defaultErrorMessage));
    }
  }
}
