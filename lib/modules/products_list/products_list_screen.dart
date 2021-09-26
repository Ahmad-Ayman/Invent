import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salesrep/models/user_pharmacies_model.dart';
import 'package:salesrep/modules/products_list/products_cubit/products_cubit.dart';
import 'package:salesrep/shared/components/constants.dart';
import 'package:salesrep/shared/components/shared_components.dart';

class ProductsListScreen extends StatelessWidget {
  PharmacyData? model;
  ProductsListScreen({this.model});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var productsCubit = ProductsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(model!.name!),
          ),
          body: Column(
            children: [
              Expanded(
                child: ConditionalBuilder(
                  condition: productsCubit.allProducts != null,
                  fallback: (context) => Center(child: CircularProgressIndicator()),
                  builder: (context) => ListView.builder(
                    itemBuilder: (context, index) => productItemBuilder(context: context, model: productsCubit.allProducts!.data![index]),
                    itemCount: productsCubit.allProducts!.data!.length,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.13,
                color: kMainColor,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: HexColor('01BEFF')))),
                              ),
                              onPressed: () {},
                              child: Text(
                                'متابعة',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'L.E ${productsCubit.totalPrice.toStringAsFixed(2)} ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        ' : إجمالي السعر ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
