import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesrep/models/user_model.dart';
import 'package:salesrep/modules/login/login_cubit/login_states.dart';
import 'package:salesrep/modules/new_requests/new_request_cubit/new_request_cubit.dart';
import 'package:salesrep/shared/network/remote/dio_helper.dart';
import 'package:salesrep/shared/network/remote/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  UserModel? userModel;
  void userLogin({required String email, required String pass, required BuildContext context}) {
    emit(LoginLoadingState());
    log('Step 1');
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': pass,
      },
    ).then((value) {
      log('Step 2');
      userModel = UserModel.fromJson(value.data);
      log('Done with token : ${userModel!.token}');
      if (NewRequestCubit.get(context).allPharmacies == null) {
        NewRequestCubit.get(context).getUserPharmacies(context);
      }
      if (NewRequestCubit.get(context).chainsModel == null) {
        NewRequestCubit.get(context).getUserChains();
      }

      emit(LoginSuccessState(userModel!));
    }).catchError(
      (error) {
        log('Step 3');
        log(error.toString());
        emit(
          LoginFailedState(error.toString()),
        );
      },
    );
  }
}
