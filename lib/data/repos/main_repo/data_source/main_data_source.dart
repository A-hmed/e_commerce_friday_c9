import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/failures.dart';
import 'package:e_commerce_friday_c9/data/model/response/cart_response.dart';
import 'package:e_commerce_friday_c9/data/model/response/categories_response.dart';
import 'package:e_commerce_friday_c9/data/model/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/products_response.dart';
import 'package:e_commerce_friday_c9/ui/utils/constants.dart';
import 'package:e_commerce_friday_c9/ui/utils/end_points.dart';
import 'package:e_commerce_friday_c9/ui/utils/shared_prefecences_utils.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../../../model/response/cart_dm.dart';

@injectable
class MainDataSource {
  SharedPrefUtils sharedPrefUtils;

  MainDataSource(this.sharedPrefUtils);

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
      //  print(url.toString());
      Response serverResponse = await get(url);
      Map json = jsonDecode(serverResponse.body);
      ProductsResponse productResponse = ProductsResponse.fromJson(json);
      //print("getProducts Body: ${json}");
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

  Future<Either<Failure, CartDM>> addProductToCart(String productId) async {
    Uri url = Uri.https(EndPoints.baseUrl, EndPoints.cart);
    String token = (await sharedPrefUtils.getToken())!;
    Response addToCartServerResponse = await post(url,
        body: {"productId": productId}, headers: {"token": token});
    Map addToCartJson = jsonDecode(addToCartServerResponse.body);
    if (addToCartServerResponse.statusCode >= 200 &&
        addToCartServerResponse.statusCode < 300) {
      return await getLoggedUserCart();
    } else {
      return Left(
          Failure(addToCartJson["message"] ?? Constants.defaultErrorMessage));
    }
  }

  Future<Either<Failure, CartDM>> removeProductFromCart(
      String productId) async {
    Uri url =
        Uri.parse("https://${EndPoints.baseUrl}${EndPoints.cart}/$productId");
    String token = (await sharedPrefUtils.getToken())!;
    Response removeFromCartServerResponse =
        await delete(url, headers: {"token": token});
    Map removeFromCartJson = jsonDecode(removeFromCartServerResponse.body);
    if (removeFromCartServerResponse.statusCode >= 200 &&
        removeFromCartServerResponse.statusCode < 300) {
      return await getLoggedUserCart();
    } else {
      return Left(Failure(
          removeFromCartJson["message"] ?? Constants.defaultErrorMessage));
    }
  }

  Future<Either<Failure, CartDM>> getLoggedUserCart() async {
    Uri url = Uri.https(EndPoints.baseUrl, EndPoints.cart);
    String token = (await sharedPrefUtils.getToken())!;
    Response getCartResponse = await get(url, headers: {"token": token});
    CartResponse cartResponse =
        CartResponse.fromJson(jsonDecode(getCartResponse.body));
    if (getCartResponse.statusCode >= 200 && getCartResponse.statusCode < 300) {
      print("Returning data");
      return Right(cartResponse.data!);
    } else {
      return Left(
          Failure(cartResponse.message ?? Constants.defaultErrorMessage));
    }
  }
}
