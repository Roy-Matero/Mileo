import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';

import 'dashboard.dart';
import 'profile.dart';


class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  PersistentTabController _tabController;

  List<Widget> buildScreens = [
    DashBoard(),
    Profile(),
  ];

  List<PersistentBottomNavBarItem> tabBarItems = [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.dashboard),
      title: 'DashBoard'
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.face),
      title: 'Profile'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: PersistentTabView(
        controller: _tabController,
        screens: buildScreens,
        items: tabBarItems,
        navBarStyle: NavBarStyle.neumorphic,
      )
    );
  }
}
