import 'package:flutter/material.dart';
import 'package:mileo/map/map_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';

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
      _tabController = PersistentTabController(initialIndex: 2);
    }

  List<Widget> screensList = [
    DashBoard(),
    MapPage(),
    Profile(),
  ];

  List<PersistentBottomNavBarItem> tabBarItems = [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.dashboard),
      title: 'DashBoard',
      activeColor: Color(0xFF0EF7F7),
      // activeColor: Colors.red,
      inactiveColor: Color(0xEFD0D3DD),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.map),
      title: 'Map',
      activeColor: Color(0xFF0EF7F7),
      inactiveColor: Color(0xEFD0D3DD),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.face),
      title: 'Profile',
      activeColor: Color(0xFF0EF7F7),
      inactiveColor: Color(0xEFD0D3DD),
    ),
  ];

  Widget bottomNavBar(BuildContext context){
    var _metrics = MediaQuery.of(context).size;
    return Container(
      child: PersistentTabView(
        controller: _tabController,
        screens: screensList,
        items: tabBarItems,
        neumorphicProperties: NeumorphicProperties(
          showSubtitleText: true,
        ),
        navBarHeight: _metrics.height * .09,
        navBarStyle: NavBarStyle.neumorphic,
        backgroundColor: Color(0xEF344589),
        onItemSelected: (value) {
          setState(() {
            _tabController.index = value;
          });
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: bottomNavBar(context),
      body: screensList[_tabController.index],
    );
  }
}