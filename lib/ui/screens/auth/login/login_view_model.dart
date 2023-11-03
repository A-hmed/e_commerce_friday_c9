import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/login_use_case.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_request_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<BaseRequestStates> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  LoginUseCase useCase;

  LoginViewModel(this.useCase) : super(BaseRequestInitialState());

  void login() async {
    if (!formKey.currentState!.validate()) return;

    emit(BaseRequestLoadingState());
    Either<String, bool> either =
    await useCase.execute(emailController.text, passwordController.text);
    print(either);
    either.fold((errorMessage) {
      emit(BaseRequestErrorState(errorMessage));
    }, (_) {
      emit(BaseRequestSuccessState());
    });
  }
}
