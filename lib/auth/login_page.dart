import 'package:flutter/material.dart';

enum formType{
    signup,
    login,
    forgotPassword,
  }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Widget emailTextField(){
    return TextField();
  }

  Widget passwordTextField(){
    return TextField();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          emailTextField()
        ],
      ),
    );
  }
}