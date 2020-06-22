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
  var index;
  @override
    void initState() { 
      super.initState();
      setState(() {
        index = 0;
      });
    }

  List<Widget> screensList = [
    DashBoard(),
    MapPage(),
    Profile(),
  ];

  List<BottomNavigationBarItem> tabBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      title: Text('DashBoard'),
      // activeColor: Color(0xFF0EF7F7),
      // inactiveColor: Color(0xEFD0D3DD),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.map),
      title: Text('Map'),
      // activeColor: Color(0xFF0EF7F7),
      // inactiveColor: Color(0xEFD0D3DD),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.face),
      title: Text('Profile'),
      // activeColor: Color(0xFF0EF7F7),
      // inactiveColor: Color(0xEFD0D3DD),
    ),
  ];

  Widget bottomNavBar(BuildContext context){
    var _metrics = MediaQuery.of(context).size;
    return Container(
      child: BottomNavigationBar(
        backgroundColor: Color(0xEF344589),
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: tabBarItems,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar(context),
      body: screensList[index],
    );
  }
}