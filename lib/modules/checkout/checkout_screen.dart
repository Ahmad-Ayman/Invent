import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesrep/models/product_model.dart';
import 'package:salesrep/models/user_pharmacies_model.dart';
import 'package:salesrep/modules/checkout/checkout_cubit/checkout_cubit.dart';

class CheckOutScreen extends StatelessWidget {
  PharmacyData? pharmacyModel;
  List<ProductData>? neededItems;
  Map<String?, int?>? quantity;

  CheckOutScreen({this.pharmacyModel, this.neededItems, this.quantity});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit(),
      child: BlocConsumer<CheckoutCubit, CheckoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(pharmacyModel!.name!),
            ),
          );
        },
      ),
    );
  }
}
