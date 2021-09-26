import 'package:salesrep/models/user_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final UserModel userModel;
  LoginSuccessState(this.userModel);
}

class LoginFailedState extends LoginStates {
  final String error;
  LoginFailedState(this.error);
}

class ChangePasswordVisibilityState extends LoginStates {}
