import 'package:e_commerce_friday_c9/domain/use_cases/products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/use_cases/categories_usecase.dart';

@injectable
class HomeViewModel extends Cubit {
  GetAllCategoriesUseCase categoriesUseCase;
  GetAllProductsUseCase getAllProductsUseCase;
  int adsIndex = 0;

  HomeViewModel(this.categoriesUseCase, this.getAllProductsUseCase)
      : super(HomeInitialState());

  getCategories() {
    categoriesUseCase.execute();
  }

  void getProducts() {
    getAllProductsUseCase.execute();
  }

  void setAdsIndex(int newIndex) {
    adsIndex = newIndex;
    emit(HomeInitialState());
  }
}

class HomeInitialState {}
