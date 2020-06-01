import 'package:flutter/foundation.dart';

@immutable
class User{
  User({this.uid, this.name, this.email, this.photoUrl, this.phoneNumber});

  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final String photoUrl;

  factory User.fromMap(Map<String, dynamic> userMap){
    return User(
      uid: userMap['uid'],
      name: userMap['name'],
      email:  userMap['email'],
      phoneNumber: userMap['phoneNumber'],
      photoUrl: userMap['photoUrl'],
    );
  }

  Map<String, dynamic> toMap(User user){
    return {
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'photoUrl': user.photoUrl,
    };
  }
}