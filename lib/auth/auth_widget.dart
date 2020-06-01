import 'package:flutter/material.dart';
import 'package:mileo/models/user_model.dart';
import 'package:mileo/views/home.dart';

import 'sign_in/email_password_auth/email_password_sign_in_page.dart';

class AuthWidget extends StatelessWidget{
  const AuthWidget({Key key, @required this.userSnapshot}): super(key: key);
  final AsyncSnapshot<User> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active){
      // return userSnapshot.hasData ? Home() : SignInPageBuilder();
      return userSnapshot.hasData ? Home() : EmailPasswordSignInPage();
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );  
  }
}