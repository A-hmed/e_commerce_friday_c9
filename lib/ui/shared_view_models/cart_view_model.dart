import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/failures.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/add_product_to_cart_usecase.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/get_logged_user_cart_usecase.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/remove_product_from_cart_usecase.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/response/cart_dm.dart';

@injectable
class CartViewModel extends Cubit {
  GetLoggedUserCartUseCase getLoggedUserCartUseCase;
  AddProductToCartUseCase addProductToCartUseCase;
  RemoveProductFromCartUseCase removeProductFromCartUseCase;
  CartDM? cartDm;

  CartViewModel(this.addProductToCartUseCase, this.removeProductFromCartUseCase,
      this.getLoggedUserCartUseCase)
      : super(BaseInitialState());

  void addProductToCart(String productId) async {
    Either<Failure, CartDM> either =
        await addProductToCartUseCase.execute(productId);
    either.fold((failure) {
      emit(BaseErrorState(failure.errorMessage));
    }, (cart) {
      cartDm = cart;
      emit(BaseSuccessState());
    });
  }

  void removeProductFromCart(String productId) async {
    Either<Failure, CartDM> either =
        await removeProductFromCartUseCase.execute(productId);
    either.fold((failure) {
      emit(BaseErrorState(failure.errorMessage));
    }, (cart) {
      cartDm = cart;
      emit(BaseSuccessState());
    });
  }

  void loadCart() async {
    Either<Failure, CartDM> either = await getLoggedUserCartUseCase.execute();
    either.fold((failure) {
      emit(BaseErrorState(failure.errorMessage));
    }, (cart) {
      cartDm = cart;
      emit(BaseSuccessState());
    });
  }
}
