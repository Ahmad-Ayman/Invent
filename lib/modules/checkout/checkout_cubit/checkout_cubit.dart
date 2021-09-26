import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesrep/layout/home_layout/home_layout.dart';
import 'package:salesrep/models/new_request_model.dart';
import 'package:salesrep/models/new_request_response_model.dart';
import 'package:salesrep/models/product_model.dart';
import 'package:salesrep/models/user_pharmacies_model.dart';
import 'package:salesrep/shared/components/constants.dart';
import 'package:salesrep/shared/network/remote/dio_helper.dart';
import 'package:salesrep/shared/network/remote/end_points.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  static CheckoutCubit get(context) => BlocProvider.of(context);

  void showFinalList(List<ProductData>? data) {
    data!.forEach((element) {
      log(element.name!);
    });
  }

  int dropDownValue = 1;
  void changeDropDownValue(int? v) {
    dropDownValue = v!;
    emit(CheckoutChangeDropDownValueState());
  }

  Map<String, dynamic> createRequestJson({PharmacyData? pharmacyData, String? note, Map<String?, int?>? quantity}) {
    List<Items> itemss = [];
    quantity!.forEach((key, value) {
      itemss.add(Items(productId: int.parse(key!), qty: value));
    });
    NewRequest a = NewRequest(
      orderType: dropDownValue,
      name: 'me',
      phoneNumber: pharmacyData!.contactPhone,
      location: '',
      note: note,
      pharmacyId: pharmacyData.id,
      pharmacyBranchId: pharmacyData.id,
      distributorId: pharmacyData.id,
      items: itemss,
    );
    log('${a.name} - ${a.note} - ${a.orderType} - ${a.phoneNumber} - ${a.location} - ${a.pharmacyId} - ${a.distributorId} - ${a.pharmacyBranchId} - ${a.items!.toList().toString()}');
    return a.toJson();
  }

  NewRequestResponseModel? newRequestResponseModel;
  void confirmNewRequest({required BuildContext context, PharmacyData? pharmData, String? note, Map<String?, int?>? quantity}) {
    emit(AddRequestLoadingState());
    log('Step 1');
    DioHelper.postData(
      url: ADD_REQUEST,
      authorization: 'Bearer $kSavedToken',
      data: createRequestJson(pharmacyData: pharmData, note: note, quantity: quantity),
    ).then((value) {
      log('Step 2');
      // newRequestResponseModel = NewRequestResponseModel.fromJson(value.data);
      log('Done with token : ${value.data}');

      emit(AddRequestSuccessState());

      kNavigateTo(context, HomeLayout());
    }).catchError(
      (error) {
        log('Step 3');
        log(error.toString());
        emit(
          AddRequestFailedState(),
        );
      },
    );
  }
}
