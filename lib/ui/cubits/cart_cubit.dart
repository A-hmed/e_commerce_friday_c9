import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/failures.dart';
import 'package:e_commerce_friday_c9/data/model/response/cart_dm.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/get_user_cart.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/remove_product_from_cart_usecase.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/add_product_to_cart_usecase.dart';

@injectable
class CartCubit extends Cubit {
  GetUserCartUseCase userCartUseCase;
  AddProductToCartUseCase addProductToCartUseCase;
  RemoveProductFromCartUseCase removeProductFromCartUseCase;

  CartCubit(this.userCartUseCase, this.addProductToCartUseCase,
      this.removeProductFromCartUseCase)
      : super(BaseInitialState());

  loadCart() async {
    Either<Failure, CartDM> either = await userCartUseCase.execute();
    either.fold((error) => emit(BaseErrorState(error.errorMessage)),
        (cart) => emit(BaseSuccessState<CartDM>(data: cart)));
  }

  addProductToCart(String productId) async {
    Either<Failure, CartDM> either =
        await addProductToCartUseCase.execute(productId);
    either.fold((error) => emit(BaseErrorState(error.errorMessage)),
        (cart) => emit(BaseSuccessState<CartDM>(data: cart)));
  }

  removeProductFromCart(String productId) async {
    Either<Failure, CartDM> either =
        await removeProductFromCartUseCase.execute(productId);
    either.fold((error) => emit(BaseErrorState(error.errorMessage)),
        (cart) => emit(BaseSuccessState<CartDM>(data: cart)));
  }
}
