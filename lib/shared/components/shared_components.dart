import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salesrep/adaptive/adaptive_indicator.dart';
import 'package:salesrep/models/product_model.dart';
import 'package:salesrep/models/user_pharmacies_model.dart';
import 'package:salesrep/modules/products_list/products_cubit/products_cubit.dart';
import 'package:salesrep/modules/products_list/products_list_screen.dart';
import 'package:salesrep/modules/products_list/products_list_screen_tablet.dart';
import 'package:salesrep/shared/components/constants.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (v) {
        onSubmit!();
      },
      validator: (v) {
        validate(v);
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        prefixIcon: Icon(
          prefix,
          color: Colors.white,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                  color: Colors.white,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      style: TextStyle(
        color: Colors.white,
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget pharmaciesItemBuilderForEven({
  required BuildContext context,
  required PharmacyData pharmacyDataModel,
}) =>
    Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListTile(
        onTap: () {
          ProductsCubit.get(context).getUserProducts(context);
          kNavigateTo(
            context,
            ProductsListScreen(model: pharmacyDataModel),
          );
        },
        title: Card(
          elevation: 10,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(pharmacyDataModel.name!),
                    Text(pharmacyDataModel.contactPhone!),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ),
    );

Widget pharmaciesItemBuilderForOdd({
  required BuildContext context,
  required PharmacyData pharmacyDataModel,
}) =>
    Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListTile(
        onTap: () {
          ProductsCubit.get(context).getUserProducts(context);
          kNavigateTo(
            context,
            ProductsListScreen(model: pharmacyDataModel),
          );
        },
        title: Card(
          elevation: 10,
          child: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
                size: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(pharmacyDataModel.name!),
                    Text(pharmacyDataModel.contactPhone!),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget pharmaciesItemBuilderForTablet({
  required BuildContext context,
  required PharmacyData pharmacyDataModel,
}) =>
    Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListTile(
        onTap: () {
          ProductsCubit.get(context).getUserProducts(context);
          kNavigateTo(
            context,
            ProductsListScreenTablet(model: pharmacyDataModel),
          );
        },
        title: Card(
          elevation: 10,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(pharmacyDataModel.name!),
              const SizedBox(
                height: 10,
              ),
              Text(pharmacyDataModel.contactPhone!),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );

Widget productItemBuilder({
  required BuildContext context,
  required ProductData model,
}) =>
    Padding(
      padding: EdgeInsets.all(10.0),
      child: ListTile(
        title: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model.name}',
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'L.E ${model.price}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.grey[500],
                                fontSize: 15,
                              ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                //  CartCubit.get(context).add(model);
                                ProductsCubit.get(context).itemPlus(model);
                              },
                              child: Text(
                                '+',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Text(ProductsCubit.get(context).productsCounter![model.id.toString()].toString()),
                            OutlinedButton(
                              onPressed: () {
                                //   CartCubit.get(context).minus(model);
                                ProductsCubit.get(context).itemMinus(model);
                              },
                              child: Text(
                                '-',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CachedNetworkImage(
                    imageUrl: 'https://hbr.org/resources/images/article_assets/2019/11/Nov19_14_sb10067951dd-001.jpg',
                    placeholder: (context, url) => Center(
                      child: AdaptiveIndicator(
                        os: getOS(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Image(
                      image: AssetImage('assets/images/maswhite.png'),
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

Widget productItemBuilderForTablet({
  required BuildContext context,
  required ProductData model,
}) =>
    Padding(
      padding: EdgeInsets.all(10.0),
      child: ListTile(
        title: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CachedNetworkImage(
                    imageUrl: 'https://hbr.org/resources/images/article_assets/2019/11/Nov19_14_sb10067951dd-001.jpg',
                    placeholder: (context, url) => Center(
                      child: AdaptiveIndicator(
                        os: getOS(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Image(
                      image: AssetImage('assets/images/maswhite.png'),
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${model.name}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'L.E ${model.price}',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey[500],
                              fontSize: 15,
                            ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              //  CartCubit.get(context).add(model);
                              ProductsCubit.get(context).itemPlus(model);
                            },
                            child: Text(
                              '+',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Text(ProductsCubit.get(context).productsCounter![model.id.toString()].toString()),
                          OutlinedButton(
                            onPressed: () {
                              //   CartCubit.get(context).minus(model);
                              ProductsCubit.get(context).itemMinus(model);
                            },
                            child: Text(
                              '-',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

Widget finalListItemBuilderForTablet({
  required BuildContext context,
  required ProductData model,
  required Map<String?, int?> quantities,
}) =>
    Padding(
      padding: EdgeInsets.all(10.0),
      child: ListTile(
        title: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text('Qty'),
                    SizedBox(
                      height: 20,
                    ),
                    Text('${quantities[model.id!.toString()]}'),
                  ],
                ),
                Spacer(),
                Expanded(
                  child: Text(
                    model.name!,
                    textAlign: TextAlign.end,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CachedNetworkImage(
                    imageUrl: 'https://hbr.org/resources/images/article_assets/2019/11/Nov19_14_sb10067951dd-001.jpg',
                    placeholder: (context, url) => Center(
                      child: AdaptiveIndicator(
                        os: getOS(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Image(
                      image: AssetImage('assets/images/maswhite.png'),
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
