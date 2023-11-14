import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/cart_dm.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_request_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/api/response/cart_product.dart';
import '../../data/model/api/response/product_dm.dart';
import '../../domain/use_cases/add_product_to_cart_usecase.dart';
import '../../domain/use_cases/get_logged_user_cart_usecase.dart';
import '../../domain/use_cases/remove_product_from_cart_usecase.dart';

@singleton
class CartViewModel extends Cubit {
  AddProductToCartUseCase addProductToCartUseCase;
  GetLoggedUserCartUseCase getLoggedCartUseCase;
  RemoveProductFromCartUseCase removeProductFromCartUseCase;
  CartDM? cartDM;

  static CartViewModel get(BuildContext context) => BlocProvider.of(context);

  CartViewModel(this.getLoggedCartUseCase, this.removeProductFromCartUseCase,
      this.addProductToCartUseCase)
      : super(BaseRequestInitialState());

  loadCart() async {
    Either<Failure, CartDM> either = await getLoggedCartUseCase.execute();
    either.fold((l) => emit(BaseRequestErrorState(l.errorMessage)), (cart) {
      cartDM = cart;
      emit(BaseRequestSuccessState());
    });
  }

  addProductToCart(String productId) async {
    Either<Failure, CartDM> either =
        await addProductToCartUseCase.execute(productId);
    either.fold((l) => emit(BaseRequestErrorState(l.errorMessage)), (cart) {
      cartDM = cart;
      emit(BaseRequestSuccessState());
    });
  }

  removeFromCart(String productId) async {
    Either<Failure, CartDM> either =
        await removeProductFromCartUseCase.execute(productId);
    either.fold((l) => emit(BaseRequestErrorState(l.errorMessage)), (cart) {
      cartDM = cart;
      emit(BaseRequestSuccessState());
    });
  }

  bool isInCart(ProductDM productDM, List<CartProduct>? cartProducts) {
    if (cartProducts == null) return false;
    for (int i = 0; i < cartProducts.length; i++) {
      if (productDM.id == cartProducts[i].product?.id) {
        return true;
      }
    }
    return false;
  }
}
