import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mileo/constants/keys.dart';
import 'package:mileo/constants/strings.dart';
import 'package:mileo/services/auth_service.dart';
import 'package:mileo/widgets/exception_alert_dialog.dart';
import 'package:provider/provider.dart';

import 'sign_in/email_link/email_link_sign_in_page.dart';
import 'sign_in/email_password_auth/email_password_sign_in_page.dart';
import 'sign_in_manager.dart';
import 'social_sign_in_button.dart';

class SignInPageBuilder extends StatelessWidget {
  // P<ValueNotifier>
  //   P<SignInManager>(valueNotifier)
  //     SignInPage(value)
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of<AuthService>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, ValueNotifier<bool> isLoading, __) =>
            Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (_, SignInManager manager, __) => SignInPage._(
              isLoading: isLoading.value,
              manager: manager,
              title: 'Welcome to mileo',
            ),
          ),
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage._({Key key, this.isLoading, this.manager, this.title})
      : super(key: key);
  final SignInManager manager;
  final String title;
  final bool isLoading;

  static const Key googleButtonKey = Key('google');
  static const Key facebookButtonKey = Key('facebook');
  static const Key emailPasswordButtonKey = Key('email-password');
  static const Key emailLinkButtonKey = Key('email-link');
  static const Key anonymousButtonKey = Key(ANONYMOUS);

  Future<void> _showSignInError(
      BuildContext context, PlatformException exception) async {
    await ExceptionAlertDialog(
      title: signInFailed,
      exception: exception,
    ).show(context);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manager.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await manager.signInWithFacebook();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }


  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    final navigator = Navigator.of(context);
    await EmailPasswordSignInPage.show(
      context,
      onSignedIn: navigator.pop,
    );
  }

   Future<void> _signInWithEmailLink(BuildContext context) async {
     final navigator = Navigator.of(context);
     await EmailLinkSignInPage.show(
       context,
       onSignedIn: navigator.pop,
     );
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(title),
      ),
      // drawer: isLoading ? null : DeveloperMenu(),
      backgroundColor: Colors.grey[200],
      body: _buildSignIn(context),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      signIn,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    // Make content scrollable so that it fits on small screens
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 32.0),
            SizedBox(
              height: 50.0,
              child: _buildHeader(),
            ),
            SizedBox(height: 32.0),
            
            SocialSignInButton(
              key: googleButtonKey,
              imageLink: 'https://centerlyne.com/wp-content/uploads/2016/10/Google_-G-_Logo.svg_.png',
              text: signInWithGoogle,
              onPressed: isLoading ? null : () => _signInWithGoogle(context),
              color: Colors.white,
            ),
            SizedBox(height: 8),
            SocialSignInButton(
              key: facebookButtonKey,
              imageLink: 'https://1000logos.net/wp-content/uploads/2016/11/Facebook-Logo.png',
              text: signInWithFacebook,
              textColor: Colors.white,
              onPressed: isLoading ? null : () => _signInWithFacebook(context),
              color: Color(0xFF334D92),
            ),
            SizedBox(height: 8),
            SignInButton(
              key: emailPasswordButtonKey,
              text: signInWithEmailPassword,
              onPressed:
                  isLoading ? null : () => _signInWithEmailAndPassword(context),
              textColor: Colors.white,
              color: Colors.teal[700],
            ),
            SizedBox(height: 8),
            SignInButton(
              key: emailLinkButtonKey,
              text: signInWithEmailLink,
               onPressed: isLoading ? null : () => _signInWithEmailLink(context),
              textColor: Colors.white,
              color: Colors.blueGrey[700],
            ),
            SizedBox(height: 8),
            Text(
              or,
              style: TextStyle(fontSize: 14.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            SignInButton(
              key: anonymousButtonKey,
              text: goAnonymous,
              color: Colors.lime[300],
              textColor: Colors.black87,
              onPressed: isLoading ? null : () => _signInAnonymously(context),
            ),
          ],
        ),
      ),
    );
  }
}