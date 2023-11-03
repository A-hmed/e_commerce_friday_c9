import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/api/request/register_request_body.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/register_use_case.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_request_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterViewModel extends Cubit<BaseRequestStates> {
  RegisterUseCase useCase;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  RegisterViewModel(this.useCase) : super(BaseRequestInitialState());

  void register() async {
    if (!key.currentState!.validate()) return;
    emit(BaseRequestLoadingState());
    Either<Failure, void> response = await useCase.execute(RegisterRequestBody(
        email: emailController.text,
        password: passwordController.text,
        rePassword: rePasswordController.text,
        phone: phoneController.text,
        name: nameController.text));

    response.fold((l) {
      emit(BaseRequestErrorState(l.errorMessage));
    }, (_) => emit(BaseRequestSuccessState()));
  }
}
