import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/category_response.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/product_dm.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/product_response.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
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
      CategoryResponse categoryResponse =
          CategoryResponse.fromJson(jsonDecode(serverResponse.body));
      if (serverResponse.statusCode >= 200 &&
          serverResponse.statusCode < 300 &&
          categoryResponse.data?.isNotEmpty == true) {
        return Right(categoryResponse.data!);
      } else {
        return Left(
            Failure(categoryResponse.message ?? Constants.defaultErrorMessage));
      }
    } catch (e) {
      print("Exception: $e");
      return Left(Failure(Constants.defaultErrorMessage));
    }
  }

  @override
  Future<Either<Failure, List<ProductDM>>> getProducts() async {
    try {
      Uri url = Uri.https(EndPoints.baseUrl, EndPoints.products);
      Response serverResponse = await get(url);
      ProductResponse productResponse =
          ProductResponse.fromJson(jsonDecode(serverResponse.body));
      if (serverResponse.statusCode >= 200 &&
          serverResponse.statusCode < 300 &&
          productResponse.data?.isNotEmpty == true) {
        return Right(productResponse.data!);
      } else {
        return Left(
            Failure(productResponse.message ?? Constants.defaultErrorMessage));
      }
    } catch (e) {
      print("Exception: $e");
      return Left(Failure(Constants.defaultErrorMessage));
    }
  }
}
