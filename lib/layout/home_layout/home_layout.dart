import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesrep/layout/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:salesrep/layout/home_layout/home_layout_cubit/home_layout_states.dart';
import 'package:salesrep/shared/components/constants.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return SafeArea(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0.0,
                title: Text(
                  homeCubit.pageTitles[homeCubit.currentIndex],
                ),
              ),
              bottomNavigationBar: FancyBottomNavigation(
                initialSelection: homeCubit.currentIndex,
                onTabChangedListener: (index) {
                  homeCubit.changeBottomNavBar(index);
                },
                tabs: homeCubit.bottomNavItems,
              ),
              body: isTabletLandscape ? homeCubit.navBarScreensTablet[homeCubit.currentIndex] : homeCubit.navBarScreens[homeCubit.currentIndex],
            ),
          ),
        );
      },
    );
  }
}
