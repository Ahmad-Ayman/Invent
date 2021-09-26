import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesrep/models/product_model.dart';
import 'package:salesrep/models/user_pharmacies_model.dart';
import 'package:salesrep/modules/checkout/checkout_screen.dart';
import 'package:salesrep/modules/checkout/checkout_screen_tablet.dart';
import 'package:salesrep/modules/login/login_screen.dart';
import 'package:salesrep/modules/login/login_screen_tablet.dart';
import 'package:salesrep/shared/components/constants.dart';
import 'package:salesrep/shared/network/remote/dio_helper.dart';
import 'package:salesrep/shared/network/remote/end_points.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  static ProductsCubit get(context) => BlocProvider.of(context);

  ProductModel? allProducts;
  Map<String?, int?>? productsCounter = {};

  void getUserProducts(context) {
    emit(GetAllProductsLoadingState());
    log('Step 1');
    log(kSavedToken);
    DioHelper.getData(
      authorization: 'Bearer $kSavedToken',
      url: PRODUCTS,
    ).then((value) {
      log('Step 2 ,   ${value.data}');
      if (value.data.toString().contains('Token is Expired')) {
        emit(ProductsTokenExpiredState());
        Widget goTo = isTabletLandscape ? LoginScreenTablet() : LoginScreen();
        kNavigateAndFinish(context, goTo);
      } else {
        allProducts = ProductModel.fromJson(value.data);
        allProducts!.data!.forEach((element) {
          productsCounter!.putIfAbsent(element.id.toString(), () => 0);
        });

        emit(GetAllProductsSuccessState());
      }
    }).catchError(
      (error) {
        log('Step 3');
        log(error.toString());
        emit(
          GetAllProductsFailedState(),
        );
      },
    );
  }

  double totalPrice = 0;
  int totalCount = 0;

  void initialCountItems(BuildContext context) {
    productsCounter!.clear();
    allProducts!.data!.forEach((element) {
      productsCounter!.putIfAbsent(element.id.toString(), () => 0);
    });
    emit(UpdateCounters());
  }

  void itemPlus(ProductData model) {
    // productsCounter![model.id.toString()] = productsCounter![model.id.toString()]! + 1;
    int counter = productsCounter!['${model.id}'] ?? 0;
    counter++;
    totalPrice += double.parse(model.price!);
    productsCounter!.update(model.id.toString(), (value) => counter);
    log(totalPrice.toString());
    emit(UpdateTotalPriceState());
  }

  void itemMinus(ProductData model) {
    int counter = productsCounter!['${model.id}'] ?? 0;
    if (counter > 0) {
      counter--;
      totalPrice -= double.parse(model.price!);
      productsCounter!.update(model.id.toString(), (value) => counter);
      log(totalPrice.toString());
      emit(UpdateTotalPriceState());
    }
  }

  void goToCheckout({PharmacyData? pharmacyData, Map<String?, int?>? neededItems, required BuildContext context}) {
    getFinalItems(neededItems, context);
    if (isTabletLandscape) {
      kNavigateTo(
        context,
        CheckOutScreenTablet(
          pharmacyModel: pharmacyData,
          neededItems: finalList,
          quantity: neededItems,
        ),
      );
    } else {
      kNavigateTo(
        context,
        CheckOutScreen(
          pharmacyModel: pharmacyData,
          neededItems: finalList,
          quantity: neededItems,
        ),
      );
    }
  }

  List<ProductData> finalList = [];
  void getFinalItems(Map<String?, int?>? quantities, context) {
    finalList = [];
    quantities!.forEach((key, value) {
      if (value != 0) {
        log(key.toString());
        finalList.addAll(allProducts!.data!.where((element) => element.id!.toString() == key!.toString()).toList());
      }
    });
  }
}
