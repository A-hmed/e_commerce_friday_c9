import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/failures.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/data/repos/main_repo/main_repo_impl.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllProductsUseCase extends Cubit {
  MainRepoImpl repo;

  GetAllProductsUseCase(this.repo) : super(BaseInitialState());

  void execute() async {
    emit(BaseLoadingState());

    Either<Failure, List<ProductDM>> either = await repo.getProducts();
    either.fold((failure) => emit(BaseErrorState(failure.errorMessage)),
        (r) => emit(BaseSuccessState<List<ProductDM>>(data: r)));
  }
}
