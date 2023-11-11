import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/data/model/response/category_dm.dart';
import 'package:e_commerce_friday_c9/domain/repos/main_repo/main_repo.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_request_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCategoriesUseCase extends Cubit {
  MainRepo repo;

  GetAllCategoriesUseCase(this.repo) : super(BaseRequestInitialState());

  void execute() async {
    emit(BaseRequestLoadingState());
    Either<Failure, List<CategoryDM>> either = await repo.getCategories();
    either.fold((failure) => emit(BaseRequestErrorState(failure.errorMessage)),
        (list) => emit(BaseRequestSuccessState<List<CategoryDM>>(data: list)));
  }
}
