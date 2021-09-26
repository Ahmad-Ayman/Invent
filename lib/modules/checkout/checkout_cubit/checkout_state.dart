part of 'checkout_cubit.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutChangeDropDownValueState extends CheckoutState {}

class AddRequestLoadingState extends CheckoutState {}

class AddRequestSuccessState extends CheckoutState {}

class AddRequestFailedState extends CheckoutState {}
