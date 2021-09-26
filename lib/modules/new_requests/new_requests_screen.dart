import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salesrep/modules/new_requests/new_request_cubit/new_request_cubit.dart';
import 'package:salesrep/modules/new_requests/new_request_cubit/new_request_states.dart';
import 'package:salesrep/shared/components/constants.dart';
import 'package:salesrep/shared/components/shared_components.dart';

class NewRequestScreen extends StatelessWidget {
  const NewRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var codeController = TextEditingController();
    var nameController = TextEditingController();

    return BlocConsumer<NewRequestCubit, NewRequestStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var newRequestsCubit = NewRequestCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    color: kMainColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: const Text(
                                  'كود الصيدلية',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: defaultFormField(
                                  type: TextInputType.number,
                                  controller: codeController,
                                  validate: (String value) {},
                                  label: 'Code',
                                  prefix: Icons.code,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: const Text(
                                  'اسم الصيدلية',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: defaultFormField(
                                  type: TextInputType.number,
                                  controller: nameController,
                                  validate: (String value) {},
                                  label: 'Code',
                                  prefix: Icons.code,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                        HexColor('01BEFF'),
                                      ),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                          side: BorderSide(
                                            color: HexColor('01BEFF'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      newRequestsCubit.onSearchPressed(
                                        name: nameController.text,
                                        code: codeController.text,
                                        context: context,
                                      );
                                    },
                                    child: const Text(
                                      'بحث',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                        HexColor('01BEFF'),
                                      ),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                          side: BorderSide(
                                            color: HexColor('01BEFF'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      // newRequestsCubit.onSearchPressed(
                                      //   name: nameController.text,
                                      //   code: codeController.text,
                                      //   context: context,
                                      // );
                                    },
                                    child: const Text(
                                      'بحث بالعلامة التجارية',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ConditionalBuilder(
                  condition: newRequestsCubit.allPharmacies != null,
                  builder: (context) => ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => index % 2 == 0
                        ? pharmaciesItemBuilderForEven(context: context, pharmacyDataModel: newRequestsCubit.allPharmacies!.data![0])
                        : pharmaciesItemBuilderForOdd(context: context, pharmacyDataModel: newRequestsCubit.allPharmacies!.data![0]),

                    itemCount: 10,
                    //newRequestsCubit.allPharmacies!.data!.length,
                  ),
                  fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
