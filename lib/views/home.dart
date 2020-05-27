import 'package:flutter/material.dart';
import 'package:mileo/map/map_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';

import 'bottom_nav_bar.dart';
import 'dashboard.dart';
import 'profile.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PersistentTabController _tabController;

  @override
    void initState() { 
      super.initState();
      _tabController = PersistentTabController(initialIndex: 0);
    }

  List<Widget> screensList = [
    DashBoard(),
    MapPage(),
    Profile(),
  ];

  List<PersistentBottomNavBarItem> tabBarItems = [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.dashboard),
      title: 'DashBoard'
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.map),
      title: 'Map'
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.face),
      title: 'Profile'
    ),
  ];

  Widget bottomNavBar(){

    return Container(
      height: 60,
      child: PersistentTabView(
        controller: _tabController,
        screens: screensList,
        items: tabBarItems,
        navBarStyle: NavBarStyle.neumorphic,
        backgroundColor: Colors.blue,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: bottomNavBar(),
      body: screensList[_tabController.index],
    );
  }
}