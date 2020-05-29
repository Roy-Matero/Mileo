import 'package:firebase_auth/firebase_auth.dart';
import 'package:mileo/models/user_model.dart';
import 'package:mileo/services/auth_service.dart';

class AuthServiceAdapter implements AuthService{

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> createUserWithEmailAndPassword({String email, String password, String name, String  uid}) {
      // TODO: implement createUserWithEmailAndPassword
      throw UnimplementedError();
    }
  
    @override
    Future<User> currentUser() {
      // TODO: implement currentUser
      throw UnimplementedError();
    }
  
    @override
    void dispose() {
      // TODO: implement dispose
    }
  
    @override
    // TODO: implement onAuthStateChanged
    Stream<User> get onAuthStateChanged => throw UnimplementedError();
  
    @override
    Future<void> sendPasswordResetEmail(String email) {
      // TODO: implement sendPasswordResetEmail
      throw UnimplementedError();
    }
  
    @override
    Future<User> sendSignInWithEmailLink({
       String email,
       String url,
       bool handleCodeInApp,
       String iOSBundleID,
       String androidPackageName,
       bool androidInstallIfNotAvailable,
       String androidMinimumVersion,
    }){

    }
  
    @override
    Future<User> signInAnonymously() {
      // TODO: implement signInAnonymously
      throw UnimplementedError();
    }
  
    @override
    Future<User> signInWithEmailAndLink({String email, String link}){
      // TODO: implement signInWithEmailAndLink
      throw UnimplementedError();
    }

    @override
    Future<bool> isSignInWithEmailLink(String email ){
      // TODO: implement isSignInWithEmailLink
      throw UnimplementedError();
    }
  
    @override
    Future<User> signInWithEmailAndPassword({String email, String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<User> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<User> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    
  }

}