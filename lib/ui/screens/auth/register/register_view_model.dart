import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/failures.dart';
import 'package:e_commerce_friday_c9/data/model/request/registe_request_body.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/register_use_case.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterViewModel extends Cubit {
  RegisterUseCase useCase;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  RegisterViewModel(this.useCase) : super(BaseInitialState());

  void register() async {
    if (!formKey.currentState!.validate()) return;
    emit(BaseLoadingState());
    Either<Failure, bool> either = await useCase.execute(RegisteRequestBody(
        name: nameController.text,
        password: passwordController.text,
        rePassword: rePasswordController.text,
        email: emailController.text,
        phone: phoneController.text));
    either.fold((error) => emit(BaseErrorState(error.errorMessage)),
        (_) => emit(BaseSuccessState()));
  }
}
