import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/login_usecase.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_request_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<BaseRequestStates> {
  LoginViewModel(this.useCase) : super(BaseRequestInitialState());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginUseCase useCase;

  void login() async {
    if (!formKey.currentState!.validate()) return;
    emit(BaseRequestLoadingState());
    Either<String, bool> eitherResponse =
        await useCase.execute(emailController.text, passwordController.text);
    eitherResponse.fold((l) => emit(BaseRequestErrorState(l)),
        (r) => emit(BaseRequestSuccessState()));
  }
}
