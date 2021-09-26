import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salesrep/layout/home_layout/home_layout.dart';
import 'package:salesrep/modules/login/login_cubit/login_cubit.dart';
import 'package:salesrep/modules/login/login_cubit/login_states.dart';
import 'package:salesrep/shared/components/constants.dart';
import 'package:salesrep/shared/components/shared_components.dart';
import 'package:salesrep/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.userModel.token != null) {
              CacheHelper.saveData(key: 'token', value: state.userModel.token).then((value) {
                kSavedToken = state.userModel.token!;
                kNavigateAndFinish(context, HomeLayout());
              });
            }
          }
        },
        builder: (context, state) {
          var loginCubit = LoginCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 40,
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: const Image(
                        image: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: HexColor('00314E'),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(30),
                              child: const Center(
                                child: Text(
                                  'مرحبا بك',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              height: 100,
                              child: defaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'email is too short';
                                  }
                                },
                                label: 'البريد الإلكتروني',
                                prefix: Icons.person,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(20),
                              height: 100,
                              child: defaultFormField(
                                controller: passwordController,
                                type: TextInputType.text,
                                isPassword: loginCubit.isPassword,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'password is too short';
                                  }
                                },
                                label: 'كلمة المرور',
                                prefix: Icons.lock_outline,
                                suffix: loginCubit.suffix,
                                suffixPressed: () {
                                  loginCubit.changePasswordVisibility();
                                },
                                onSubmit: (value) {
                                  if (formKey.currentState!.validate()) {
                                    log('hello');
                                  }
                                },
                              ),
                            ),
                            ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              fallback: (context) => const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                              builder: (context) => Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.12,
                                padding: const EdgeInsets.all(20),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      HexColor('01BEFF'),
                                    ),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: HexColor('01BEFF')))),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      loginCubit.userLogin(email: emailController.text, pass: passwordController.text, context: context);
                                    }
                                  },
                                  child: const Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
