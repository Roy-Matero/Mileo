import 'package:flutter/foundation.dart';
import 'package:mileo/models/user_model.dart';

abstract class AuthService{
    Future<User> currentUser();
    Future<User> signInAnonymously();
    Future<User> signInWithEmailAndPassword({String email, String password});
    Future<User> createUserWithEmailAndPassword({
      String email,
      String password,
      String name,
      String uid,
    });
    Future<void> sendPasswordResetEmail(String email);
    Future<User> signInWithEmailAndLink({String email, String link});
    Future<bool> isSignInWithEmailLink(String link);
    Future<User> sendSignInWithEmailLink({
      @required String email,
      @required String url,
      @required bool handleCodeInApp,
      @required String iOSBundleID,
      @required String androidPackageName,
      @required bool androidInstallIfNotAvailable,
      @required String androidMinimumVersion,
    });
}