import 'package:flutter/material.dart';
import 'package:mileo/models/user_model.dart';
import 'package:mileo/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);

  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<User>(
      stream: authService.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot){
        final User user = snapshot.data;
        if(user != null){
          print('User not null');
          return MultiProvider(
            providers: [
              Provider<User>.value(value: user),
            ],
            child: builder(context, snapshot),
          );
        }
        // print('user null');
        return builder(context, snapshot);
      },
    );
  }
}