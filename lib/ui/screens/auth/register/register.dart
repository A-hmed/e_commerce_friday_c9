
import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/form_label.dart';

class Register extends StatelessWidget {
  static const String routeName = 'register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Image.asset(
            'assets/images/route_logo.png',
            height: 71,
            width: 237,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
               //   key: viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FormLabelWidget(label: 'Full Name'),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomTextFormField(
                          hintText: 'enter your full name',
                          controller: TextEditingController(),
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter full name';
                            }
                            return null;
                          },
                          type: TextInputType.name),
                      const SizedBox(
                        height: 32,
                      ),
                      FormLabelWidget(label: 'Email Address'),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomTextFormField(
                          hintText: 'enter your email address',
                          controller: TextEditingController(),
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter email';
                            }
                            var emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text);
                            if (!emailValid) {
                              return 'email format not valid';
                            }

                            return null;
                          },
                          type: TextInputType.emailAddress),
                      const SizedBox(
                        height: 32,
                      ),
                      FormLabelWidget(label: 'Mobile Number'),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomTextFormField(
                          hintText: 'enter your mobile number',
                          controller: TextEditingController(),
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter mobile number';
                            }
                            if (text.trim().length < 10) {
                              return 'Phone number should be at least 10 numbers.';
                            }
                            return null;
                          },
                          type: TextInputType.phone),
                      const SizedBox(
                        height: 32,
                      ),
                      FormLabelWidget(label: 'Password'),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomTextFormField(
                        hintText: 'enter your password',
                        controller: TextEditingController(),
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter password ';
                          }
                          if (text.length < 6) {
                            return 'Phone number should be at least 6 chrs.';
                          }
                          return null;
                        },
                        type: TextInputType.visiblePassword,
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      FormLabelWidget(label: 'Password Confirmation'),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomTextFormField(
                        hintText: 're-enter your password confirmation',
                        controller: TextEditingController(),
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please re-enter password ';
                          }
                          if (true) {
                            return "Password doesn't match.";
                          }
                          return null;
                        },
                        type: TextInputType.visiblePassword,
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 56,
                      ),
                      CustomButtonWidget(
                          title: 'Sign Up',
                          onPressed: () {

                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
