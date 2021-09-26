import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salesrep/models/product_model.dart';
import 'package:salesrep/models/user_pharmacies_model.dart';
import 'package:salesrep/modules/checkout/checkout_cubit/checkout_cubit.dart';
import 'package:salesrep/modules/products_list/products_cubit/products_cubit.dart';
import 'package:salesrep/shared/components/constants.dart';
import 'package:salesrep/shared/components/shared_components.dart';

class CheckOutScreenTablet extends StatelessWidget {
  PharmacyData? pharmacyModel;
  List<ProductData>? neededItems;
  Map<String?, int?>? quantity;

  CheckOutScreenTablet({this.pharmacyModel, this.neededItems, this.quantity});
  var noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit()..showFinalList(neededItems),
      child: BlocConsumer<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutInitial) print(neededItems!.toList().toString());
        },
        builder: (context, state) {
          var cubit = CheckoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(pharmacyModel!.name!),
            ),
            body: Row(
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: kMainColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    child: Directionality(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        dropdownColor: kSecondaryColor2,
                                        value: cubit.dropDownValue,
                                        items: [
                                          DropdownMenuItem(
                                            child: Text("طلب جديد"),
                                            value: 1,
                                          ),
                                          DropdownMenuItem(
                                            child: Text("طلب سابق"),
                                            value: 2,
                                          ),
                                        ],
                                        onChanged: (int? value) {
                                          cubit.changeDropDownValue(value);
                                        },
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                    width: MediaQuery.of(context).size.width * 0.2,
                                  ),
                                  flex: 5,
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: const Text(
                                    'نوع الطلب ',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                    child: Directionality(
                                      child: TextField(
                                        controller: noteController,
                                        style: TextStyle(
                                          color: kMainColor,
                                        ),
                                        maxLines: 10,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                                            borderRadius: BorderRadius.circular(25.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                                            borderRadius: BorderRadius.circular(25.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                                            borderRadius: BorderRadius.circular(25.0),
                                          ),
                                        ),
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                    width: MediaQuery.of(context).size.width * 0.2,
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: const Text(
                                    'ملحوظات ',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: Text(
                                ' L.E السعر الإجمالي : ${ProductsCubit.get(context).totalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 55.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                        HexColor('01BEFF'),
                                      ),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: HexColor('01BEFF')))),
                                    ),
                                    onPressed: () {
                                      cubit.confirmNewRequest(
                                          context: context, pharmData: pharmacyModel, note: noteController.text, quantity: quantity);
                                    },
                                    child: Text(
                                      'تأكيد الطلب ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => finalListItemBuilderForTablet(
                      context: context,
                      model: neededItems![index],
                      quantities: quantity!,
                    ),
                    itemCount: neededItems!.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
