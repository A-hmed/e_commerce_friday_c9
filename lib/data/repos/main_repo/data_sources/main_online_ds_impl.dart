import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/failures.dart';
import 'package:e_commerce_friday_c9/data/model/response/categorie_response.dart';
import 'package:e_commerce_friday_c9/data/model/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/products_response.dart';
import 'package:e_commerce_friday_c9/domain/repos/main_repo/data_sources/main_online_ds.dart';
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
      var myResponse =
          CategoriesResponse.fromJson(jsonDecode(serverResponse.body));
      if (serverResponse.statusCode >= 200 &&
          serverResponse.statusCode < 300 &&
          myResponse.data?.isNotEmpty == true) {
        return Right(myResponse.data!);
      } else {
        return Left(
            Failure(myResponse.message ?? Constants.defaultErrorMessage));
      }
    } catch (error, stacktrace) {
      print("Handling exception: ${error}, stackTrace: $stacktrace");
      return Left(Failure(Constants.defaultErrorMessage));
    }
  }

  @override
  Future<Either<Failure, List<ProductDM>>> getProducts() async {
    try {
      Uri url = Uri.https(EndPoints.baseUrl, EndPoints.products);
      Response serverResponse = await get(url);
      var myResponse =
          ProductsResponse.fromJson(jsonDecode(serverResponse.body));
      if (serverResponse.statusCode >= 200 &&
          serverResponse.statusCode < 300 &&
          myResponse.data?.isNotEmpty == true) {
        return Right(myResponse.data!);
      } else {
        return Left(
            Failure(myResponse.message ?? Constants.defaultErrorMessage));
      }
    } catch (error, stacktrace) {
      print("Handling exception: ${error}, stackTrace: $stacktrace");
      return Left(Failure(Constants.defaultErrorMessage));
    }
  }
}
