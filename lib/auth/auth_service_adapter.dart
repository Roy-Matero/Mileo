import 'dart:async';

import 'package:mileo/models/user_model.dart';
import 'package:mileo/resources/firebase_auth_methods.dart';
import 'package:mileo/services/auth_service.dart';

class AuthServiceAdapter implements AuthService {
  static final FirebaseAuthMethods _firebaseAuthMethods = FirebaseAuthMethods();

  AuthService authService = _firebaseAuthMethods;

  static StreamSubscription<User> _firebaseAuthSubscription =
        _firebaseAuthMethods.onAuthStateChanged.listen((User user) {
      _onAuthStateChangedController.add(user);
    }, onError: (dynamic error) {
      _onAuthStateChangedController.addError(error);
    });

  static final StreamController<User> _onAuthStateChangedController =
      StreamController<User>.broadcast();

  // void _setup() {
  //   _firebaseAuthSubscription =
  //       _firebaseAuthMethods.onAuthStateChanged.listen((User user) {
  //     _onAuthStateChangedController.add(user);
  //   }, onError: (dynamic error) {
  //     _onAuthStateChangedController.addError(error);
  //   });
  // }

  @override
  Future<User> createUserWithEmailAndPassword(
      {String email, String password, String name, String uid}) => 
        authService.createUserWithEmailAndPassword(
          email: email, 
          password: password,
          name: name,
          uid: uid,
        );

  @override
  Future<User> currentUser() => authService.currentUser();

  @override
  void dispose() {
    _firebaseAuthSubscription.cancel();
    _onAuthStateChangedController.close();
  }

  @override
  Stream<User> get onAuthStateChanged => _onAuthStateChangedController.stream;

  @override
  Future<void> sendPasswordResetEmail(String email) =>
      authService.sendPasswordResetEmail(email);

  @override
  Future<User> sendSignInWithEmailLink({
    String email,
    String url,
    bool handleCodeInApp,
    String iOSBundleID,
    String androidPackageName,
    bool androidInstallIfNotAvailable,
    String androidMinimumVersion,
  }) => authService.sendSignInWithEmailLink(
    email: email,
    url: url,
    handleCodeInApp: handleCodeInApp,
    iOSBundleID: iOSBundleID,
    androidPackageName: androidPackageName,
    androidInstallIfNotAvailable: androidInstallIfNotAvailable,
    androidMinimumVersion: androidMinimumVersion
  );

  @override
  Future<User> signInAnonymously() => authService.signInAnonymously();
  @override
  Future<User> signInWithEmailAndLink({String email, String link}) => 
      authService.signInWithEmailAndLink(email: email, link: link);

  @override
  Future<bool> isSignInWithEmailLink(String link) => 
      authService.isSignInWithEmailLink(link);

  @override
  Future<User> signInWithEmailAndPassword({String email, String password}) =>
      authService.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<User> signInWithFacebook() =>
      authService.signInWithFacebook();

  @override
  Future<User> signInWithGoogle() => 
      authService.signInWithGoogle();

  @override
  Future<void> signOut() => authService.signOut();
}
