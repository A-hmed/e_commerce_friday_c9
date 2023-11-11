import 'package:e_commerce_friday_c9/domain/use_cases/get_all_categories_usecase.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/get_all_products_usecase.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_request_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends Cubit {
  GetAllCategoriesUseCase getAllCategoriesUseCase;
  GetAllProductsUseCase getAllProductsUseCase;

  HomeViewModel(this.getAllCategoriesUseCase, this.getAllProductsUseCase)
      : super(BaseRequestInitialState());

  loadCategories() {
    getAllCategoriesUseCase.execute();
  }

  loadProducts() {
    getAllProductsUseCase.execute();
  }
}
