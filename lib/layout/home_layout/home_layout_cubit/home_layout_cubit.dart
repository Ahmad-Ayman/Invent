import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesrep/layout/home_layout/home_layout_cubit/home_layout_states.dart';
import 'package:salesrep/modules/history/history_screen.dart';
import 'package:salesrep/modules/history/history_screen_tablet.dart';
import 'package:salesrep/modules/new_requests/new_requests_screen.dart';
import 'package:salesrep/modules/new_requests/new_requests_screen_tablet.dart';
import 'package:salesrep/modules/profile/profile_screen.dart';
import 'package:salesrep/modules/profile/profile_screen_tablet.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 1;
  List<TabData> bottomNavItems = [
    TabData(
      iconData: Icons.history,
      title: "طلباتي",
    ),
    TabData(
      iconData: Icons.add,
      title: "طلب جديد",
    ),
    TabData(
      iconData: Icons.person,
      title: "حسابي",
    ),
  ];
  List<Widget> navBarScreens = [
    HistoryScreen(),
    NewRequestScreen(),
    ProfileScreen(),
  ];
  List<Widget> navBarScreensTablet = [
    HistoryScreenTablet(),
    NewRequestScreenTablet(),
    ProfileScreenTablet(),
  ];
  List<String> pageTitles = [
    'طلباتي',
    'طلب جديد',
    'حسابي',
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavState());
  }
}
