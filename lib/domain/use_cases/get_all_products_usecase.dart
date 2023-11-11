import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/failure.dart';
import '../../data/model/response/product_dm.dart';
import '../../ui/utils/base_request_states.dart';
import '../repos/main_repo/main_repo.dart';

@injectable
class GetAllProductsUseCase extends Cubit {
  MainRepo repo;

  GetAllProductsUseCase(this.repo) : super(BaseRequestInitialState());

  void execute() async {
    emit(BaseRequestLoadingState());
    Either<Failure, List<ProductDM>> either = await repo.getProducts();
    either.fold((failure) => emit(BaseRequestErrorState(failure.errorMessage)),
        (list) => emit(BaseRequestSuccessState<List<ProductDM>>(data: list)));
  }
}
