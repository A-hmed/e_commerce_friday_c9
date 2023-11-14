import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/base_response.dart'
    as model;
import 'package:e_commerce_friday_c9/data/model/api/response/cart_dm.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/cart_response.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/category_response.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/product_dm.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/product_response.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/data/utils/shared_pref_utils.dart';
import 'package:e_commerce_friday_c9/domain/repos/main_repo/ds/main_online_ds.dart';
import 'package:e_commerce_friday_c9/ui/utils/constants.dart';
import 'package:e_commerce_friday_c9/ui/utils/end_points.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MainOnlineDS)
class MainOnlineDSImpl extends MainOnlineDS {
  SharedPrefUtils sharedPrefUtils;

  MainOnlineDSImpl(this.sharedPrefUtils);

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

  @override
  Future<Either<Failure, CartDM>> getLoggedCart() async {
    print("getLoggedCart");
    try {
      Uri uri = Uri.https(EndPoints.baseUrl, EndPoints.cart);
      String token = (await sharedPrefUtils.getToken())!;
      Response serverResponse = await get(uri, headers: {"token": token});
      CartResponse cartResponse =
          CartResponse.fromJson(jsonDecode(serverResponse.body));
      if (serverResponse.statusCode >= 200 &&
          serverResponse.statusCode < 300 &&
          cartResponse.data != null) {
        return Right(cartResponse.data!);
      } else {
        return Left(
            Failure(cartResponse.message ?? Constants.defaultErrorMessage));
      }
    } catch (e, stackTrace) {
      print("MainOnlineDSImpl:getLoggedCart-> $e, $stackTrace");
      return Left(Failure(Constants.defaultErrorMessage));
    }
  }

  @override
  Future<Either<Failure, CartDM>> addProductToCart(String productId) async {
    print("addProductToCart");
    try {
      Uri uri = Uri.https(EndPoints.baseUrl, EndPoints.cart);
      String token = (await sharedPrefUtils.getToken())!;
      Response serverResponse = await post(uri,
          body: {"productId": productId}, headers: {"token": token});
      Map json = jsonDecode(serverResponse.body);
      model.BaseResponse myResponse = model.BaseResponse.fromJson(json);
      if (serverResponse.statusCode >= 200 && serverResponse.statusCode < 300) {
        return getLoggedCart();
      } else {
        print(myResponse.message);
        return Left(
            Failure(myResponse.message ?? Constants.defaultErrorMessage));
      }
    } catch (e, stackTrace) {
      print("MainOnlineDSImpl:getLoggedCart-> $e, $stackTrace");
      return Left(Failure(Constants.defaultErrorMessage));
    }
  }

  @override
  Future<Either<Failure, CartDM>> removeProductFromCart(
      String productId) async {
    print("removeProductFromCart");
    try {
      Uri uri =
          Uri.parse("https://${EndPoints.baseUrl}${EndPoints.cart}/$productId");
      String token = (await sharedPrefUtils.getToken())!;
      Response serverResponse = await delete(uri, headers: {"token": token});
      Map json = jsonDecode(serverResponse.body);
      model.BaseResponse myResponse = model.BaseResponse.fromJson(json);
      if (serverResponse.statusCode >= 200 && serverResponse.statusCode < 300) {
        return getLoggedCart();
      } else {
        return Left(
            Failure(myResponse.message ?? Constants.defaultErrorMessage));
      }
    } catch (e, stackTrace) {
      print("MainOnlineDSImpl:removeProductFromCart-> $e, $stackTrace");
      return Left(Failure(Constants.defaultErrorMessage));
    }
  }
}
