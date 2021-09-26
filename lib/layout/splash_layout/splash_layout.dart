import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salesrep/adaptive/adaptive_indicator.dart';
import 'package:salesrep/layout/home_layout/home_layout.dart';
import 'package:salesrep/modules/login/login_screen.dart';
import 'package:salesrep/modules/login/login_screen_tablet.dart';
import 'package:salesrep/modules/new_requests/new_request_cubit/new_request_cubit.dart';
import 'package:salesrep/shared/components/constants.dart';
import 'package:salesrep/shared/network/local/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Image(
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Center(
                    child: AdaptiveIndicator(
                      os: getOS(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Loading...',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> setOrientation() async {
    if (isTabletLandscape) {
      await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft],
      );
    } else {
      await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp],
      ); //
    }

    ///write your method body here
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String token = CacheHelper.getData(key: 'token') ?? 'No';
    if (token != 'No') {
      kSavedToken = token;
    } else {
      kSavedToken = 'No';
    }
    setOrientation();
    if (kSavedToken != 'No') {
      if (NewRequestCubit.get(context).allPharmacies == null) {
        NewRequestCubit.get(context).getUserPharmacies(context);
      }
      if (NewRequestCubit.get(context).chainsModel == null) {
        NewRequestCubit.get(context).getUserChains();
      }
    }

    Timer(
      Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: kSavedToken == 'No' ? (isTabletLandscape ? LoginScreenTablet() : LoginScreen()) : HomeLayout(),
          ),
        ),
      ),
    );
  }
}
