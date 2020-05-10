import 'package:flutter/material.dart';
import 'package:mileo/views/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mileo',
      home: DashBoard(),
    );
    }
}