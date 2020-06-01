import 'package:flutter/material.dart';
import 'package:mileo/widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    Key key,
    String imageLink,
    String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : super(
    key: key,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.network(imageLink),
        Text(
          text,
          style: TextStyle(color: textColor, fontSize: 15.0),
        ),
        Opacity(
          opacity: 0.0,
          child: Image.network(imageLink),
        ),
      ],
    ),
    color: color,
    onPressed: onPressed,
  );
}

class SignInButton extends CustomRaisedButton {
  SignInButton({
    Key key,
    @required String text,
    @required Color color,
    @required VoidCallback onPressed,
    Color textColor = Colors.black87,
    double height = 50.0,
  }) : super(
          key: key,
          child: Text(text, style: TextStyle(color: textColor, fontSize: 15.0)),
          color: color,
          textColor: textColor,
          height: height,
          onPressed: onPressed,
        );
}