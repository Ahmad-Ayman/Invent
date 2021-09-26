import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesrep/bloc_observer.dart';
import 'package:salesrep/layout/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:salesrep/layout/splash_layout/splash_layout.dart';
import 'package:salesrep/modules/new_requests/new_request_cubit/new_request_cubit.dart';
import 'package:salesrep/modules/products_list/products_cubit/products_cubit.dart';
import 'package:salesrep/shared/components/constants.dart';
import 'package:salesrep/shared/network/local/cache_helper.dart';
import 'package:salesrep/shared/network/remote/dio_helper.dart';
import 'package:salesrep/shared/style/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initAppDio();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(create: (context) => NewRequestCubit()),
        BlocProvider(create: (context) => ProductsCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: mainColor,
        ),
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: LayoutBuilder(
            builder: (builder, constraints) {
              var checkType = constraints.maxWidth > 1000;
              isTabletLandscape = checkType;
              return const SplashScreen();
            },
          ),
        ),
      ),
    );
  }
}
