import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/failures.dart';
import 'package:e_commerce_friday_c9/data/model/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/data/repos/main_repo/data_source/main_data_source.dart';
import 'package:e_commerce_friday_c9/ui/utils/constants.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainRepoImpl {
  MainDataSource mainDataSource;
  Connectivity connectivity;

  MainRepoImpl(this.mainDataSource, this.connectivity);

  Future<Either<Failure, List<CategoryDM>>> getCategories() async {
    var result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      return mainDataSource.getCategories();
    } else {
      return Left(Failure(Constants.internetErrorMessage));
    }
  }

  Future<Either<Failure, List<ProductDM>>> getProducts() async {
    var result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      return mainDataSource.getProducts();
    } else {
      return Left(Failure(Constants.internetErrorMessage));
    }
  }
}
