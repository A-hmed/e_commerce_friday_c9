import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/request/register_request_body.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/register_usecase.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_request_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterViewModel extends Cubit<BaseRequestStates> {
  RegisterUseCase useCase;

  RegisterViewModel(this.useCase) : super(BaseRequestInitialState());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  register() async {
    if (!formKey.currentState!.validate()) return;
    emit(BaseRequestLoadingState());
    Either<String, bool> eitherResponse = await useCase.execute(
        RegisterRequestBody(
            email: emailController.text,
            name: nameController.text,
            password: passwordController.text,
            rePassword: rePasswordController.text,
            phone: phoneController.text));
    eitherResponse.fold((l) => emit(BaseRequestErrorState(l)),
        (r) => emit(BaseRequestSuccessState()));
  }
}
