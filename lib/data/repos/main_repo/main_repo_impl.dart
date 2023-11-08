import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/failures.dart';
import 'package:e_commerce_friday_c9/data/model/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/domain/repos/main_repo/data_sources/main_online_ds.dart';
import 'package:e_commerce_friday_c9/domain/repos/main_repo/main_repo.dart';
import 'package:e_commerce_friday_c9/ui/utils/constants.dart';
import 'package:e_commerce_friday_c9/ui/utils/extensions.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MainRepo)
class MainRepoImpl extends MainRepo {
  Connectivity connectivity;
  MainOnlineDS ds;

  MainRepoImpl(this.connectivity, this.ds);

  @override
  Future<Either<Failure, List<CategoryDM>>> getCategories() async {
    if (await connectivity.isInternetConnected) {
      return ds.getCategories();
    } else {
      return Left(Failure(Constants.internetErrorMessage));
    }
  }

  @override
  Future<Either<Failure, List<ProductDM>>> getProducts() async {
    if (await connectivity.isInternetConnected) {
      return ds.getProducts();
    } else {
      return Left(Failure(Constants.internetErrorMessage));
    }
  }
}
