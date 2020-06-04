import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mileo/models/user_model.dart';
import 'package:mileo/services/auth_service.dart';

class FirebaseAuthMethods implements AuthService{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser firebaseUser){
    if(firebaseUser == null){
      print('The user is null check the methods');
      return null;
    }
    return User(
      uid: firebaseUser.uid,
      email: firebaseUser.email,
      name: firebaseUser.displayName,
      phoneNumber: firebaseUser.phoneNumber,
      photoUrl: firebaseUser.photoUrl,
    );
  }

  @override
  Future<User> createUserWithEmailAndPassword({String email, 
                        String password, String name, String uid}) async{
      
      final AuthResult _authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      return _userFromFirebase(_authResult.user);
    }
  
    @override
    Future<User> currentUser() async{
      final FirebaseUser user = await _firebaseAuth.currentUser();
      return _userFromFirebase(user);
    }
  
    @override
    void dispose() {}
  
    @override
    Future<bool> isSignInWithEmailLink(String link) async{
      return await _firebaseAuth.isSignInWithEmailLink(link);
    }
  
    @override
    Stream<User> get onAuthStateChanged {
      return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
    }
  
    @override
    Future<void> sendPasswordResetEmail(String email) async{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    }
  
    @override
     Future<void> sendSignInWithEmailLink({
       @required String email,
       @required String url,
       @required bool handleCodeInApp,
       @required String iOSBundleID,
       @required String androidPackageName,
       @required bool androidInstallIfNotAvailable,
       @required String androidMinimumVersion,
    }) async {
       return await _firebaseAuth.sendSignInWithEmailLink(
        email: email,
        url: url,
        handleCodeInApp: handleCodeInApp,
        iOSBundleID: iOSBundleID,
        androidPackageName: androidPackageName,
        androidInstallIfNotAvailable: androidInstallIfNotAvailable,
        androidMinimumVersion: androidMinimumVersion,
      );
    }
  
    @override
    Future<User> signInAnonymously() async{
      final AuthResult authResult = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(authResult.user);
    }
  
    @override
    Future<User> signInWithEmailAndLink({String email, String link}) async{
      final AuthResult authResult = await _firebaseAuth
          .signInWithEmailAndLink(email: email, link: link);

      return _userFromFirebase(authResult.user);
    }
  
    @override
    Future<User> signInWithEmailAndPassword({String email, String password}) async{
      final AuthResult authResult = await _firebaseAuth
          .signInWithCredential(EmailAuthProvider.getCredential(
            email: email,
            password: password,
          ));
      return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signInWithFacebook() async{
    // final FacebookLogin facebookLogin = FacebookLogin();
    // facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;

    // final FacebookLoginResult result = 
    //     await facebookLogin.logIn(<String>['public_profile']);
    // if(result.accessToken != null){
    //   final AuthResult authResult = await _firebaseAuth
    //       .signInWithCredential(
    //         FacebookAuthProvider.getCredential(
    //           accessToken: result.accessToken.token
    //         ),
    //       );
    //   return _userFromFirebase(authResult.user);
    // } else {
    //   throw PlatformException(
    //     code: 'ERROR_ABORTED_BY_USER', 
    //     message: 'Sign in aborted by user',
    //   );
    // }
  }

  @override
  Future<User> signInWithGoogle() async{
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if(googleUser != null){
      final GoogleSignInAuthentication googleAuth = 
        await googleUser.authentication;

      if(googleAuth.accessToken != null && googleAuth.idToken != null){
        final AuthResult authResult = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.getCredential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ));
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user'
      );
    }
  }

  @override
  Future<void> signOut() async{
    final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
    // final FacebookLogin facebookLogin = FacebookLogin();
      // await facebookLogin.logOut();
    return _firebaseAuth.signOut();
  }

}