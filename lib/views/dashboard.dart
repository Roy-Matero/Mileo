import 'package:flutter/material.dart';
import 'package:mileo/services/firebase_methods.dart';
import 'package:mileo/views/app_bar.dart';
import 'package:mileo/views/bottom_nav_bar.dart';


class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      bottomNavigationBar: BottomNavBar(),
      body: Container(
      ),
    );
  }
}


