import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesrep/models/user_chains_model.dart';
import 'package:salesrep/models/user_pharmacies_model.dart';
import 'package:salesrep/modules/login/login_screen.dart';
import 'package:salesrep/modules/login/login_screen_tablet.dart';
import 'package:salesrep/modules/new_requests/new_request_cubit/new_request_states.dart';
import 'package:salesrep/modules/searched_pharmacies/searched_pharmacies_screen_tablet.dart';
import 'package:salesrep/shared/components/constants.dart';
import 'package:salesrep/shared/network/remote/dio_helper.dart';
import 'package:salesrep/shared/network/remote/end_points.dart';

class NewRequestCubit extends Cubit<NewRequestStates> {
  NewRequestCubit() : super(NewRequestInitState());

  static NewRequestCubit get(context) => BlocProvider.of(context);

  Pharmacies? allPharmacies;
  void getUserPharmacies(context) {
    emit(NewRequestsGetAllPharmaciesLoadingState());
    log('Step 1');
    log('$kSavedToken');
    DioHelper.getData(
      authorization: 'Bearer $kSavedToken',
      url: PHARMACIES,
    ).then((value) {
      log('Step 2 ,   ${value.data}');
      if (value.data.toString().contains('Token is Expired')) {
        emit(NewRequestTokenExpiredState());
        Widget goTo = isTabletLandscape ? LoginScreenTablet() : LoginScreen();
        kNavigateAndFinish(context, goTo);
      } else {
        allPharmacies = Pharmacies.fromJson(value.data);
        emit(NewRequestsGetAllPharmaciesSuccessState());
      }
    }).catchError(
      (error) {
        log('Step 3');
        log(error.toString());
        emit(
          NewRequestsGetAllPharmaciesFailedState(),
        );
      },
    );
  }

  Chains? chainsModel;
  void getUserChains() {
    emit(NewRequestsGetAllChainsLoadingState());
    log('Step 1');
    DioHelper.getData(
      authorization: 'Bearer $kSavedToken',
      url: CHAINS,
    ).then((value) {
      log('Step 2 ,   ${value.data}');
      if (value.data.toString().contains('Token is Expired')) {
        emit(NewRequestTokenExpiredState());
      } else {
        chainsModel = Chains.fromJson(value.data);
        emit(NewRequestsGetAllChainsSuccessState());
      }
    }).catchError(
      (error) {
        log('Step 3');
        log(error.toString());
        emit(
          NewRequestsGetAllChainsFailedState(),
        );
      },
    );
  }

  List<PharmacyData>? searchedPharmacies = [];
  void searchPharmacies(String searchedCode, String searchedName) {
    searchedPharmacies = [];
    emit(PharmaciesSearchLoadingState());
    if (searchedCode.isNotEmpty && searchedName.isEmpty) {
      searchedPharmacies = allPharmacies!.data!.where((i) => i.id.toString().contains(searchedCode)).toList();
      log('Welcomeee : ${allPharmacies!.data!.where((i) => i.id.toString().contains(searchedCode)).toList()}');
    } else if (searchedCode.isEmpty && searchedName.isNotEmpty) {
      log('Helloooo');
      searchedPharmacies = allPharmacies!.data!.where((i) => i.name!.toLowerCase().contains(searchedName.toLowerCase())).toList();
    } else if (searchedCode.isNotEmpty && searchedName.isNotEmpty) {
      log('Noooooooooo');
      searchedPharmacies = allPharmacies!.data!
          .where((i) => i.name!.toLowerCase().contains(searchedName.toLowerCase()) && i.id.toString().contains(searchedCode))
          .toList();
    }
    if (searchedPharmacies!.isNotEmpty) {
      emit(PharmaciesSearchSuccessState());
    } else {
      emit(PharmaciesSearchErrorState());
    }
  }

  void onSearchPressed({
    String? name,
    String? code,
    required BuildContext context,
  }) {
    searchPharmacies(name!, code!);
    kNavigateTo(
      context,
      SearchedPharmaciesScreenTablet(
        searchedList: searchedPharmacies,
      ),
    );
  }
}
