import 'package:flutter/material.dart';

import 'app_bar.dart';
import 'bottom_nav_bar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}