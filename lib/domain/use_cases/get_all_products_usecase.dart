import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/product_dm.dart';
import 'package:e_commerce_friday_c9/domain/repos/main_repo/main_repo.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_request_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/failure.dart';

@injectable
class GetAllProductsUseCase extends Cubit {
  MainRepo repo;

  GetAllProductsUseCase(this.repo) : super(BaseRequestInitialState());

  void execute() async {
    Either<Failure, List<ProductDM>> either = await repo.getProducts();
    either.fold((failure) => emit(BaseRequestErrorState(failure.errorMessage)),
        (list) => emit(BaseRequestSuccessState<List<ProductDM>>(data: list)));
  }
}
