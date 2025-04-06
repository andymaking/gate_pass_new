import 'package:flutter/material.dart';
import 'package:gate_pass/screens/base-vm.dart';

import '../../../gen/assets.gen.dart';
import '../book/book.ui.dart';
import '../communities/communities.ui.dart';
import '../history/history.ui.dart';
import '../home/home_screen.ui.dart';
import '../profile/profile.home.ui.dart';

class BottomNavigationViewModel extends BaseViewModel {

  List<NavType> navs = [
    NavType(
        name: "Home",
        activeIcon: Assets.svg.home,
    ),
    NavType(
      name: "History",
      activeIcon: Assets.svg.history,
    ),
    NavType(
        name: "Book",
        activeIcon: Assets.svg.book,
    ),
    NavType(
        name: "Profile",
        activeIcon: Assets.svg.profile,
    ),
    NavType(
        name: "Communities",
        activeIcon: Assets.svg.community,
    ),
  ];

  int index = 0;

  changeIndex(int val){
    index = val;
    notifyListeners();
  }

  init(int startIndex){
    index = startIndex;
    notifyListeners();
  }

  List<Widget> screens = const [
    HomeScreenView(),
    HistoryScreen(),
    BookScreen(),
    ProfileHomeScreen(),
    CommunityScreen(),
  ];

}

class NavType {
  String name;
  String activeIcon;

  NavType({required this.name, required this.activeIcon});
}