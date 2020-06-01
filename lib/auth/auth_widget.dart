import 'package:flutter/material.dart';
import 'package:mileo/auth/sign_in_page.dart';
import 'package:mileo/models/user_model.dart';
import 'package:mileo/views/home.dart';


class AuthWidget extends StatelessWidget{
  const AuthWidget({Key key, @required this.userSnapshot}): super(key: key);
  final AsyncSnapshot<User> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active){
      return userSnapshot.hasData ? Home() : SignInPageBuilder();
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );  
  }
}