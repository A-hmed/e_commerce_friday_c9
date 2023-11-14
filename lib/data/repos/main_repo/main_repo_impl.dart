import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/cart_dm.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/product_dm.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/domain/repos/main_repo/ds/main_online_ds.dart';
import 'package:e_commerce_friday_c9/domain/repos/main_repo/main_repo.dart';
import 'package:e_commerce_friday_c9/ui/utils/constants.dart';
import 'package:e_commerce_friday_c9/ui/utils/extenions.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MainRepo)
class MainRepoImpl extends MainRepo {
  MainOnlineDS onlineDS;
  Connectivity connectivity;

  MainRepoImpl(this.onlineDS, this.connectivity);

  @override
  Future<Either<Failure, List<CategoryDM>>> getCategories() async {
    if (await connectivity.isInternetConnected) {
      return onlineDS.getCategories();
    } else {
      return Left(Failure(Constants.internetErrorMessage));
    }
  }

  @override
  Future<Either<Failure, List<ProductDM>>> getProducts() async {
    if (await connectivity.isInternetConnected) {
      return onlineDS.getProducts();
    } else {
      return Left(Failure(Constants.internetErrorMessage));
    }
  }

  @override
  Future<Either<Failure, CartDM>> addProductToCart(String productId) async {
    if (await connectivity.isInternetConnected) {
      return onlineDS.addProductToCart(productId);
    } else {
      return Left(Failure(Constants.internetErrorMessage));
    }
  }

  @override
  Future<Either<Failure, CartDM>> getLoggedCart() async {
    if (await connectivity.isInternetConnected) {
      return onlineDS.getLoggedCart();
    } else {
      return Left(Failure(Constants.internetErrorMessage));
    }
  }

  @override
  Future<Either<Failure, CartDM>> removeProductFromCart(
      String productId) async {
    if (await connectivity.isInternetConnected) {
      return onlineDS.removeProductFromCart(productId);
    } else {
      return Left(Failure(Constants.internetErrorMessage));
    }
  }
}
