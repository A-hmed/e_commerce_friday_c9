import 'package:e_commerce_friday_c9/domain/use_cases/get_all_categories_usecase.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/get_all_products_use_case.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends Cubit {
  GetAllProductsUseCase getAllProductsUseCase;
  GetAllCategoriesUseCase getAllCategoriesUseCase;

  HomeViewModel(this.getAllCategoriesUseCase, this.getAllProductsUseCase)
      : super(BaseInitialState());

  void loadCategories() {
    getAllCategoriesUseCase.execute();
  }

  void loadProducts() {
    getAllProductsUseCase.execute();
  }
}
