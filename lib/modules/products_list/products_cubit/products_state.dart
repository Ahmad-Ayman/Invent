part of 'products_cubit.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class GetAllProductsLoadingState extends ProductsState {}

class GetAllProductsSuccessState extends ProductsState {}

class GetAllProductsFailedState extends ProductsState {}

class ProductsTokenExpiredState extends ProductsState {}

class UpdateCounters extends ProductsState {}

class UpdateTotalPriceState extends ProductsState {}
