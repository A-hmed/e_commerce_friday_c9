import 'package:e_commerce_friday_c9/domain/di/di.dart';
import 'package:e_commerce_friday_c9/ui/screens/auth/login/login_view_model.dart';
import 'package:e_commerce_friday_c9/ui/screens/auth/register/register.dart';
import 'package:e_commerce_friday_c9/ui/screens/home/home.dart';
import 'package:e_commerce_friday_c9/ui/utils/app_assets.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_states.dart';
import 'package:e_commerce_friday_c9/ui/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/form_label.dart';

class Login extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginViewModel viewModel = getIt<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocListener(
        bloc: viewModel,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Image.asset(AppAssets.routeLogo),
                  const SizedBox(
                    height: 86,
                  ),
                  Text(
                    'Welcome Back To Route',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Please sign in with your mail',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  FormLabelWidget(
                    label: 'Email Address',
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                      controller: viewModel.emailController,
                      hintText: 'enter your email address',
                      // controller: viewModel.emailController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter email';
                        }
                        var emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);

                        if (!emailValid) {
                          return 'Email format is not valid';
                        }

                        return null;
                      },
                      type: TextInputType.emailAddress),
                  const SizedBox(
                    height: 32,
                  ),
                  FormLabelWidget(
                    label: 'Password',
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                    hintText: 'enter your password',
                    // controller: viewModel.passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter password ';
                      }
                      if (text.length < 6) {
                        return 'Password should be at least 6 chrs.';
                      }
                      return null;
                    },
                    type: TextInputType.visiblePassword,
                    isPassword: true,
                    controller: viewModel.passwordController,
                  ),
                  const SizedBox(
                    height: 56,
                  ),
                  CustomButtonWidget(
                      title: 'Login',
                      onPressed: () {
                        viewModel.login();
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FormLabelWidget(label: "Don't have an account ? "),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Register.routeName);
                        },
                        child: FormLabelWidget(label: 'Create Account'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        listener: (context, state) {
          print("state: $state");
          if (state is BaseLoadingState) {
            showLoading(context);
          } else if (state is BaseSuccessState) {
            Navigator.pop(context);
            Navigator.pushNamed(context, Home.routeName);
          } else if (state is BaseErrorState) {
            Navigator.pop(context);
            showErrorDialog(context, state.errorMessage);
          }
        },
      ),
    );
  }
}
