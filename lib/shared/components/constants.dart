import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salesrep/modules/login/login_screen.dart';
import 'package:salesrep/shared/network/local/cache_helper.dart';

/// Logged User Token
String kSavedToken = '';

/// Phone or Tab
var isTabletLandscape = false;

/// Main Color
Color kMainColor = HexColor('00314E');
Color kSecondaryColor1 = HexColor('56D500');
Color kSecondaryColor2 = HexColor('01BEFF');

/// Navigate to another page with the old one in the stack
void kNavigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

/// Navigate to another page and remove the old one from the stack
void kNavigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

void kSignOut(BuildContext context) {
  CacheHelper.removeData(key: 'token').then(
    (value) {
      kNavigateAndFinish(context, LoginScreen());
    },
  );
}

/// get OS
String getOS() {
  return Platform.operatingSystem;
}

void buildToast({required String toastText}) {
  Fluttertoast.showToast(
      msg: toastText,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: kMainColor,
      textColor: Colors.white,
      fontSize: 18.0);
}
